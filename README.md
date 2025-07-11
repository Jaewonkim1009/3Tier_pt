  <img src="https://capsule-render.vercel.app/api?type=waving&color=auto&height=300&section=header&text=AWS%20웹서비스%20기반%20로그인%2F회원가입%20페이지%20구현%20프로젝트&fontSize=45&animation=fadeIn&fontAlignY=38"/>

</p>


<h2 align="center">
  <a href="https://docs.google.com/presentation/d/11bmyAXGamzG9ASpGTUpu6ezx78wA_Nr8/edit?slide=id.p1#slide=id.p1">
    프로젝트 발표 프레젠테이션 바로가기
  </a>
</h2>


## 프로젝트 개요

본 프로젝트는 AWS 클라우드 환경에서 로그인 및 회원가입 기능이 포함된 웹 애플리케이션을 개발하고, Docker와 Kubernetes를 통해 컨테이너화하여 배포한 프로젝트입니다. JSP를 기반으로 프론트엔드를 구성하고, MariaDB를 데이터 저장소로 활용하였으며, AWS 인프라를 실습 중심으로 구성했습니다.

---

## 🗓️ 프로젝트 타임라인
![Timeline](https://github.com/user-attachments/assets/3bbde723-e9b7-4309-9104-ca127e24c12c)


---

## 프로젝트 팀원

| 이름 | 담당 역할 |
| :---: | :--- |
| **김영범** | 프로젝트 설정<br> 관리대장 작성<br> YAML 파일 작성|
| **김재원** | 프로젝트 시방서 제작<br> 프로젝트 요구사항 정리<br> 쿠버네티스 환경 및 인프라 구성<br> |
| **권나현** | 로그인, 회원가입 기능 컨테이너화<br> |
| **서동찬** | RDS기반 DB테이블 생성

---

## 개발 환경

- AWS EC2 / VPC / IAM
- Ubuntu 22.04 서버
- Xshell / XFTP 8
- Docker
- Kubernetes
- MariaDB
- JSP (Tomcat)

---

## 주요 기능

- 사용자 로그인 및 회원가입 처리
- 사용자 정보 저장 및 관리
- 보안 그룹 기반 접근 통제
- 컨테이너 기반 배포 자동화
- Kubernetes로 서비스 확장성 확보

---

## 사용 기술

| 항목 | 내용 |
|------|------|
| 클라우드 인프라 | AWS (EC2, VPC, IAM, ECS) |
| 컨테이너화 | Docker |
| 오케스트레이션 | Kubernetes |
| 데이터베이스 | MariaDB |
| 웹 개발 | JSP, Tomcat |
| 설정 관리 | YAML, Dockerfile |

---

## 전체 구조 및 아키텍처

이 프로젝트는 **3-Tier 구조**로 구성되며, 각 계층은 명확하게 분리되어 있습니다.
<img width="1175" height="661" alt="3Tier" src="https://github.com/user-attachments/assets/c321c9ad-4327-4fe8-8649-32c0cf77f420" />
- **Presentation Layer (JSP)**: 사용자 로그인/회원가입 UI 제공
- **Application Layer (Tomcat)**: 사용자 요청 처리 및 DB 연동
- **Data Layer (MariaDB)**: 사용자 데이터 저장 및 인증 처리

### AWS 인프라 구성 요소

- EC2 인스턴스: 웹 서버 및 DB 서버 호스팅
- VPC 및 보안 그룹: 네트워크 격리 및 접근 제어
- IAM 역할: 권한 관리
- Kubernetes 클러스터: 서비스 배포 및 확장
- Docker: 모든 구성 요소의 이미지화 및 실행

### 아키텍처 다이어그램

<img width="1285" height="824" alt="아키텍처 시방서" src="https://github.com/user-attachments/assets/9d714e8f-0eb3-4ef5-a8a7-303801711b36" />

---






