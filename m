Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7JDmHRw009147
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 19 Aug 2002 06:48:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7JDmH7T009146
	for linux-mips-outgoing; Mon, 19 Aug 2002 06:48:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7JDlTRw009134;
	Mon, 19 Aug 2002 06:47:29 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g7JDngXb027272;
	Mon, 19 Aug 2002 06:49:42 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA05276;
	Mon, 19 Aug 2002 06:49:41 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g7JDneb06492;
	Mon, 19 Aug 2002 15:49:40 +0200 (MEST)
Message-ID: <3D60F773.3C64C13E@mips.com>
Date: Mon, 19 Aug 2002 15:49:39 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: IPC syscall fixup (o32 conversion layer)
References: <3D5131C7.17F9E00@mips.com> <20020813052324.A22438@linux-mips.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> Carsten,
>
> On Wed, Aug 07, 2002 at 04:42:15PM +0200, Carsten Langgaard wrote:
>
> > Here is a patch that fixes the ipc syscalls in the o32
> > wrapper/conversion routines.
> > Needed when running a 64-bit kernel on an o32 userland.
>
> before I finally apply this one, can you do me a favour and check your
> code is still working correctly even after I applied yesterdays fix
> which changes struct msqid64_id to eleminate the mismatch of the kernel
> and libc definitions?
>

It should be fine, I have this change in my local sources already.



>
> Thanks,
>
>   Ralf
>
> > Index: arch/mips64/kernel/linux32.c
> > ===================================================================
> > RCS file: /cvs/linux/arch/mips64/kernel/linux32.c,v
> > retrieving revision 1.42.2.9
> > diff -u -r1.42.2.9 linux32.c
> > --- arch/mips64/kernel/linux32.c      2002/07/23 12:26:09     1.42.2.9
> > +++ arch/mips64/kernel/linux32.c      2002/08/07 14:28:03
> > @@ -35,8 +35,16 @@
> >  #include <asm/mman.h>
> >  #include <asm/ipc.h>
> >
> > -
> > +/* Use this to get at 32-bit user passed pointers. */
> > +/* A() macro should be used for places where you e.g.
> > +   have some internal variable u32 and just want to get
> > +   rid of a compiler warning. AA() has to be used in
> > +   places where you want to convert a function argument
> > +   to 32bit pointer or when you e.g. access pt_regs
> > +   structure and want to consider 32bit registers only.
> > + */
> >  #define A(__x) ((unsigned long)(__x))
> > +#define AA(__x) ((unsigned long)((int)__x))
> >
> >  #ifdef __MIPSEB__
> >  #define merge_64(r1,r2)      ((((r1) & 0xffffffffUL) << 32) + ((r2) & 0xffffffffUL))
> > @@ -1494,6 +1502,19 @@
> >          unsigned short  seq;
> >  };
> >
> > +struct ipc64_perm32 {
> > +     key_t key;
> > +     __kernel_uid_t32 uid;
> > +     __kernel_gid_t32 gid;
> > +     __kernel_uid_t32 cuid;
> > +     __kernel_gid_t32 cgid;
> > +     __kernel_mode_t32 mode;
> > +     unsigned short seq;
> > +     unsigned short __pad1;
> > +     unsigned int __unused1;
> > +     unsigned int __unused2;
> > +};
> > +
> >  struct semid_ds32 {
> >          struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
> >          __kernel_time_t32 sem_otime;              /* last semop time */
> > @@ -1522,6 +1543,23 @@
> >          __kernel_ipc_pid_t32 msg_lrpid;
> >  };
> >
> > +struct msqid64_ds32 {
> > +     struct ipc64_perm32 msg_perm;
> > +     __kernel_time_t32 msg_stime;
> > +     unsigned int __unused1;
> > +     __kernel_time_t32 msg_rtime;
> > +     unsigned int __unused2;
> > +     __kernel_time_t32 msg_ctime;
> > +     unsigned int __unused3;
> > +     unsigned int msg_cbytes;
> > +     unsigned int msg_qnum;
> > +     unsigned int msg_qbytes;
> > +     __kernel_pid_t32 msg_lspid;
> > +     __kernel_pid_t32 msg_lrpid;
> > +     unsigned int __unused4;
> > +     unsigned int __unused5;
> > +};
> > +
> >  struct shmid_ds32 {
> >          struct ipc_perm32       shm_perm;
> >          int                     shm_segsz;
> > @@ -1533,9 +1571,25 @@
> >          unsigned short          shm_nattch;
> >  };
> >
> > +struct ipc_kludge32 {
> > +     u32 msgp;
> > +     s32 msgtyp;
> > +};
> > +
> >  #define IPCOP_MASK(__x)      (1UL << (__x))
> >
> >  static int
> > +ipc_parse_version32(int *cmd)
> > +{
> > +     if (*cmd & IPC_64) {
> > +             *cmd ^= IPC_64;
> > +             return IPC_64;
> > +     } else {
> > +             return IPC_OLD;
> > +     }
> > +}
> > +
> > +static int
> >  do_sys32_semctl(int first, int second, int third, void *uptr)
> >  {
> >       union semun fourth;
> > @@ -1603,12 +1657,15 @@
> >  static int
> >  do_sys32_msgsnd (int first, int second, int third, void *uptr)
> >  {
> > -     struct msgbuf *p = kmalloc (second + sizeof (struct msgbuf)
> > -                                 + 4, GFP_USER);
> >       struct msgbuf32 *up = (struct msgbuf32 *)uptr;
> > +     struct msgbuf *p;
> >       mm_segment_t old_fs;
> >       int err;
> >
> > +     if (second < 0)
> > +             return -EINVAL;
> > +     p = kmalloc (second + sizeof (struct msgbuf)
> > +                                 + 4, GFP_USER);
> >       if (!p)
> >               return -ENOMEM;
> >       err = get_user (p->mtype, &up->mtype);
> > @@ -1636,18 +1693,21 @@
> >       int err;
> >
> >       if (!version) {
> > -             struct ipc_kludge *uipck = (struct ipc_kludge *)uptr;
> > -             struct ipc_kludge ipck;
> > +             struct ipc_kludge32 *uipck = (struct ipc_kludge32 *)uptr;
> > +             struct ipc_kludge32 ipck;
> >
> >               err = -EINVAL;
> >               if (!uptr)
> >                       goto out;
> >               err = -EFAULT;
> > -             if (copy_from_user (&ipck, uipck, sizeof (struct ipc_kludge)))
> > +             if (copy_from_user (&ipck, uipck, sizeof (struct ipc_kludge32)))
> >                       goto out;
> > -             uptr = (void *)A(ipck.msgp);
> > +             uptr = (void *)AA(ipck.msgp);
> >               msgtyp = ipck.msgtyp;
> >       }
> > +
> > +     if (second < 0)
> > +             return -EINVAL;
> >       err = -ENOMEM;
> >       p = kmalloc (second + sizeof (struct msgbuf) + 4, GFP_USER);
> >       if (!p)
> > @@ -1673,9 +1733,10 @@
> >  {
> >       int err = -EINVAL, err2;
> >       struct msqid_ds m;
> > -     struct msqid64_ds m64;
> > -     struct msqid_ds32 *up = (struct msqid_ds32 *)uptr;
> > +     struct msqid_ds32 *up32 = (struct msqid_ds32 *)uptr;
> > +     struct msqid64_ds32 *up64 = (struct msqid64_ds32 *)uptr;
> >       mm_segment_t old_fs;
> > +     int version = ipc_parse_version32(&second);
> >
> >       switch (second) {
> >
> > @@ -1686,10 +1747,25 @@
> >               break;
> >
> >       case IPC_SET:
> > -             err = get_user (m.msg_perm.uid, &up->msg_perm.uid);
> > -             err |= __get_user (m.msg_perm.gid, &up->msg_perm.gid);
> > -             err |= __get_user (m.msg_perm.mode, &up->msg_perm.mode);
> > -             err |= __get_user (m.msg_qbytes, &up->msg_qbytes);
> > +             if (version == IPC_64) {
> > +                     if (!access_ok(VERIFY_READ, up64, sizeof(*up64))) {
> > +                             err = -EFAULT;
> > +                             break;
> > +                     }
> > +                     err = __get_user(m.msg_perm.uid, &up64->msg_perm.uid);
> > +                     err |= __get_user(m.msg_perm.gid, &up64->msg_perm.gid);
> > +                     err |= __get_user(m.msg_perm.mode, &up64->msg_perm.mode);
> > +                     err |= __get_user(m.msg_qbytes, &up64->msg_qbytes);
> > +             } else {
> > +                     if (!access_ok(VERIFY_READ, up32, sizeof(*up32))) {
> > +                             err = -EFAULT;
> > +                             break;
> > +                     }
> > +                     err = __get_user(m.msg_perm.uid, &up32->msg_perm.uid);
> > +                     err |= __get_user(m.msg_perm.gid, &up32->msg_perm.gid);
> > +                     err |= __get_user(m.msg_perm.mode, &up32->msg_perm.mode);
> > +                     err |= __get_user(m.msg_qbytes, &up32->msg_qbytes);
> > +             }
> >               if (err)
> >                       break;
> >               old_fs = get_fs ();
> > @@ -1702,27 +1778,54 @@
> >       case MSG_STAT:
> >               old_fs = get_fs ();
> >               set_fs (KERNEL_DS);
> > -             err = sys_msgctl (first, second, (void *) &m64);
> > +             err = sys_msgctl (first, second, &m);
> >               set_fs (old_fs);
> > -             err2 = put_user (m64.msg_perm.key, &up->msg_perm.key);
> > -             err2 |= __put_user(m64.msg_perm.uid, &up->msg_perm.uid);
> > -             err2 |= __put_user(m64.msg_perm.gid, &up->msg_perm.gid);
> > -             err2 |= __put_user(m64.msg_perm.cuid, &up->msg_perm.cuid);
> > -             err2 |= __put_user(m64.msg_perm.cgid, &up->msg_perm.cgid);
> > -             err2 |= __put_user(m64.msg_perm.mode, &up->msg_perm.mode);
> > -             err2 |= __put_user(m64.msg_perm.seq, &up->msg_perm.seq);
> > -             err2 |= __put_user(m64.msg_stime, &up->msg_stime);
> > -             err2 |= __put_user(m64.msg_rtime, &up->msg_rtime);
> > -             err2 |= __put_user(m64.msg_ctime, &up->msg_ctime);
> > -             err2 |= __put_user(m64.msg_cbytes, &up->msg_cbytes);
> > -             err2 |= __put_user(m64.msg_qnum, &up->msg_qnum);
> > -             err2 |= __put_user(m64.msg_qbytes, &up->msg_qbytes);
> > -             err2 |= __put_user(m64.msg_lspid, &up->msg_lspid);
> > -             err2 |= __put_user(m64.msg_lrpid, &up->msg_lrpid);
> > -             if (err2)
> > -                     err = -EFAULT;
> > +             if (version == IPC_64) {
> > +                     if (!access_ok(VERIFY_WRITE, up64, sizeof(*up64))) {
> > +                             err = -EFAULT;
> > +                             break;
> > +                     }
> > +                     err2 = __put_user(m.msg_perm.key, &up64->msg_perm.key);
> > +                     err2 |= __put_user(m.msg_perm.uid, &up64->msg_perm.uid);
> > +                     err2 |= __put_user(m.msg_perm.gid, &up64->msg_perm.gid);
> > +                     err2 |= __put_user(m.msg_perm.cuid, &up64->msg_perm.cuid);
> > +                     err2 |= __put_user(m.msg_perm.cgid, &up64->msg_perm.cgid);
> > +                     err2 |= __put_user(m.msg_perm.mode, &up64->msg_perm.mode);
> > +                     err2 |= __put_user(m.msg_perm.seq, &up64->msg_perm.seq);
> > +                     err2 |= __put_user(m.msg_stime, &up64->msg_stime);
> > +                     err2 |= __put_user(m.msg_rtime, &up64->msg_rtime);
> > +                     err2 |= __put_user(m.msg_ctime, &up64->msg_ctime);
> > +                     err2 |= __put_user(m.msg_cbytes, &up64->msg_cbytes);
> > +                     err2 |= __put_user(m.msg_qnum, &up64->msg_qnum);
> > +                     err2 |= __put_user(m.msg_qbytes, &up64->msg_qbytes);
> > +                     err2 |= __put_user(m.msg_lspid, &up64->msg_lspid);
> > +                     err2 |= __put_user(m.msg_lrpid, &up64->msg_lrpid);
> > +                     if (err2)
> > +                             err = -EFAULT;
> > +             } else {
> > +                     if (!access_ok(VERIFY_WRITE, up32, sizeof(*up32))) {
> > +                             err = -EFAULT;
> > +                             break;
> > +                     }
> > +                     err2 = __put_user(m.msg_perm.key, &up32->msg_perm.key);
> > +                     err2 |= __put_user(m.msg_perm.uid, &up32->msg_perm.uid);
> > +                     err2 |= __put_user(m.msg_perm.gid, &up32->msg_perm.gid);
> > +                     err2 |= __put_user(m.msg_perm.cuid, &up32->msg_perm.cuid);
> > +                     err2 |= __put_user(m.msg_perm.cgid, &up32->msg_perm.cgid);
> > +                     err2 |= __put_user(m.msg_perm.mode, &up32->msg_perm.mode);
> > +                     err2 |= __put_user(m.msg_perm.seq, &up32->msg_perm.seq);
> > +                     err2 |= __put_user(m.msg_stime, &up32->msg_stime);
> > +                     err2 |= __put_user(m.msg_rtime, &up32->msg_rtime);
> > +                     err2 |= __put_user(m.msg_ctime, &up32->msg_ctime);
> > +                     err2 |= __put_user(m.msg_cbytes, &up32->msg_cbytes);
> > +                     err2 |= __put_user(m.msg_qnum, &up32->msg_qnum);
> > +                     err2 |= __put_user(m.msg_qbytes, &up32->msg_qbytes);
> > +                     err2 |= __put_user(m.msg_lspid, &up32->msg_lspid);
> > +                     err2 |= __put_user(m.msg_lrpid, &up32->msg_lrpid);
> > +                     if (err2)
> > +                             err = -EFAULT;
> > +             }
> >               break;
> > -
> >       }
> >
> >       return err;
> > @@ -1845,7 +1948,7 @@
> >
> >       case SEMOP:
> >               /* struct sembuf is the same on 32 and 64bit :)) */
> > -             err = sys_semop (first, (struct sembuf *)A(ptr),
> > +             err = sys_semop (first, (struct sembuf *)AA(ptr),
> >                                second);
> >               break;
> >       case SEMGET:
> > @@ -1853,36 +1956,36 @@
> >               break;
> >       case SEMCTL:
> >               err = do_sys32_semctl (first, second, third,
> > -                                    (void *)A(ptr));
> > +                                    (void *)AA(ptr));
> >               break;
> >
> >       case MSGSND:
> >               err = do_sys32_msgsnd (first, second, third,
> > -                                    (void *)A(ptr));
> > +                                    (void *)AA(ptr));
> >               break;
> >       case MSGRCV:
> >               err = do_sys32_msgrcv (first, second, fifth, third,
> > -                                    version, (void *)A(ptr));
> > +                                    version, (void *)AA(ptr));
> >               break;
> >       case MSGGET:
> >               err = sys_msgget ((key_t) first, second);
> >               break;
> >       case MSGCTL:
> > -             err = do_sys32_msgctl (first, second, (void *)A(ptr));
> > +             err = do_sys32_msgctl (first, second, (void *)AA(ptr));
> >               break;
> >
> >       case SHMAT:
> >               err = do_sys32_shmat (first, second, third,
> > -                                   version, (void *)A(ptr));
> > +                                   version, (void *)AA(ptr));
> >               break;
> >       case SHMDT:
> > -             err = sys_shmdt ((char *)A(ptr));
> > +             err = sys_shmdt ((char *)AA(ptr));
> >               break;
> >       case SHMGET:
> >               err = sys_shmget (first, second, third);
> >               break;
> >       case SHMCTL:
> > -             err = do_sys32_shmctl (first, second, (void *)A(ptr));
> > +             err = do_sys32_shmctl (first, second, (void *)AA(ptr));
> >               break;
> >       default:
> >               err = -EINVAL;

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
