Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3UF8lB12389
	for linux-mips-outgoing; Mon, 30 Apr 2001 08:08:47 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3UF8VM12381
	for <linux-mips@oss.sgi.com>; Mon, 30 Apr 2001 08:08:32 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3U3ivT01249
	for linux-mips@oss.sgi.com; Mon, 30 Apr 2001 00:44:57 -0300
Date: Mon, 30 Apr 2001 00:44:57 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: linux-mips@oss.sgi.com
Subject: Re: shm ipc broken
Message-ID: <20010430004457.A1227@bacchus.dhis.org>
References: <20010429210601.A16687@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010429210601.A16687@bilbo.physik.uni-konstanz.de>; from guido.guenther@gmx.net on Sun, Apr 29, 2001 at 09:06:01PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Apr 29, 2001 at 09:06:01PM +0200, Guido Guenther wrote:

> The attached patch fixes a problem with shm ipc. The structs ipc_perm in
> /u/i/bits/ipc.h and ipc64_perm in include/asm/ipcbuf.h had different sizes
> and so caused the copy_shminfo_to_user in ipc/shm.c to corrupt user space(the
> kernel structure was 8 bytes larger). This is probably not the correct fix,
> since the other arches have this padding, so maybe glibc must be fixed.
> There's still a small problem since shm_nattch is a short in glibc and a long
> in the kernel, so the attach-numbers are wrong(which I'm also not sure where
> it has to be fixed).  

Thanks for the report.  Now, the kernel interface is what it is supposed
to be so you patch was unacceptable.  Instead I've sent below patch to
to the libc maintainers for inclusion.  Also for semaphores we also had
a structure missmatch.

Yet again it's amazing how long systems can apparently work reliable with
such capital bugs ...

  Ralf

2001-04-29  Ralf Baechle  <ralf@gnu.org>

	* sysdeps/unix/sysv/linux/mips/bits/sem.h: Make structure definitions
	match the kernel definitions.
	sysdeps/unix/sysv/linux/mips/bits/ipc.h: Likewise.
	sysdeps/unix/sysv/linux/mips/bits/shm.h: Likewise.


diff -urN libc-cygnus/sysdeps/unix/sysv/linux/mips/bits/ipc.h libc-mips/sysdeps/unix/sysv/linux/mips/bits/ipc.h
--- libc-cygnus/sysdeps/unix/sysv/linux/mips/bits/ipc.h	Sun Apr 29 20:42:52 2001
+++ libc-mips/sysdeps/unix/sysv/linux/mips/bits/ipc.h	Sun Apr 29 21:07:14 2001
@@ -20,7 +20,7 @@
 # error "Never use <bits/ipc.h> directly; include <sys/ipc.h> instead."
 #endif
 
-#include <sys/types.h>
+#include <bits/types.h>
 
 /* Mode bits for `msgget', `semget', and `shmget'.  */
 #define IPC_CREAT	01000		/* Create key if key does not exist. */
@@ -43,34 +43,13 @@
 struct ipc_perm
   {
     __key_t __key;			/* Key.  */
-    long int uid;			/* Owner's user ID.  */
-    long int gid;			/* Owner's group ID.  */
-    long int cuid;			/* Creator's user ID.  */
-    long int cgid;			/* Creator's group ID.  */
-    unsigned long int mode;		/* Read/write permission.  */
+    unsigned int uid;			/* Owner's user ID.  */
+    unsigned int gid;			/* Owner's group ID.  */
+    unsigned int cuid;			/* Creator's user ID.  */
+    unsigned int cgid;			/* Creator's group ID.  */
+    unsigned int mode;			/* Read/write permission.  */
     unsigned short int __seq;		/* Sequence number.  */
+    unsigned short int __pad1;
+    unsigned long int __unused1;
+    unsigned long int __unused2;
   };
-
-
-__BEGIN_DECLS
-
-/* The actual system call: all functions are multiplexed by this.  */
-extern int __ipc (int __call, int __first, int __second, int __third,
-		  void *__ptr) __THROW;
-
-__END_DECLS
-
-#ifdef __USE_GNU
-/* The codes for the functions to use the multiplexer `__ipc'.  */
-# define IPCOP_semop	 1
-# define IPCOP_semget	 2
-# define IPCOP_semctl	 3
-# define IPCOP_msgsnd	11
-# define IPCOP_msgrcv	12
-# define IPCOP_msgget	13
-# define IPCOP_msgctl	14
-# define IPCOP_shmat	21
-# define IPCOP_shmdt	22
-# define IPCOP_shmget	23
-# define IPCOP_shmctl	24
-#endif
diff -urN libc-cygnus/sysdeps/unix/sysv/linux/mips/bits/sem.h libc-mips/sysdeps/unix/sysv/linux/mips/bits/sem.h
--- libc-cygnus/sysdeps/unix/sysv/linux/mips/bits/sem.h	Wed Dec 31 21:00:00 1969
+++ libc-mips/sysdeps/unix/sysv/linux/mips/bits/sem.h	Sun Apr 29 21:07:14 2001
@@ -0,0 +1,85 @@
+/* Copyright (C) 1995, 1996, 1997, 1998, 2000 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Library General Public License as
+   published by the Free Software Foundation; either version 2 of the
+   License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Library General Public License for more details.
+
+   You should have received a copy of the GNU Library General Public
+   License along with the GNU C Library; see the file COPYING.LIB.  If not,
+   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+   Boston, MA 02111-1307, USA.  */
+
+#ifndef _SYS_SEM_H
+# error "Never include <bits/sem.h> directly; use <sys/sem.h> instead."
+#endif
+
+#include <sys/types.h>
+
+/* Flags for `semop'.  */
+#define SEM_UNDO	0x1000		/* undo the operation on exit */
+
+/* Commands for `semctl'.  */
+#define GETPID		11		/* get sempid */
+#define GETVAL		12		/* get semval */
+#define GETALL		13		/* get all semval's */
+#define GETNCNT		14		/* get semncnt */
+#define GETZCNT		15		/* get semzcnt */
+#define SETVAL		16		/* set semval */
+#define SETALL		17		/* set all semval's */
+
+
+/* Data structure describing a set of semaphores.  */
+struct semid_ds
+{
+  struct ipc_perm sem_perm;		/* operation permission struct */
+  __time_t sem_otime;			/* last semop() time */
+  __time_t sem_ctime;			/* last time changed by semctl() */
+  unsigned long int sem_nsems;		/* number of semaphores in set */
+  unsigned long int __unused1;
+  unsigned long int __unused2;
+};
+
+/* The user should define a union like the following to use it for arguments
+   for `semctl'.
+
+   union semun
+   {
+     int val;				<= value for SETVAL
+     struct semid_ds *buf;		<= buffer for IPC_STAT & IPC_SET
+     unsigned short int *array;		<= array for GETALL & SETALL
+     struct seminfo *__buf;		<= buffer for IPC_INFO
+   };
+
+   Previous versions of this file used to define this union but this is
+   incorrect.  One can test the macro _SEM_SEMUN_UNDEFINED to see whether
+   one must define the union or not.  */
+#define _SEM_SEMUN_UNDEFINED	1
+
+#ifdef __USE_MISC
+
+/* ipcs ctl cmds */
+# define SEM_STAT 18
+# define SEM_INFO 19
+
+struct  seminfo
+{
+  int semmap;
+  int semmni;
+  int semmns;
+  int semmnu;
+  int semmsl;
+  int semopm;
+  int semume;
+  int semusz;
+  int semvmx;
+  int semaem;
+};
+
+#endif /* __USE_MISC */
diff -urN libc-cygnus/sysdeps/unix/sysv/linux/mips/bits/shm.h libc-mips/sysdeps/unix/sysv/linux/mips/bits/shm.h
--- libc-cygnus/sysdeps/unix/sysv/linux/mips/bits/shm.h	Sun Apr 29 20:42:52 2001
+++ libc-mips/sysdeps/unix/sysv/linux/mips/bits/shm.h	Sun Apr 29 21:11:06 2001
@@ -20,7 +20,7 @@
 # error "Never include <bits/shm.h> directly; use <sys/shm.h> instead."
 #endif
 
-#include <sys/types.h>
+#include <bits/types.h>
 
 /* Permission flag for shmget.  */
 #define SHM_R		0400		/* or S_IRUGO from <linux/stat.h> */
@@ -36,20 +36,22 @@
 #define SHM_UNLOCK	12		/* unlock segment (root only) */
 
 
+/* Type to count number of attaches.  */
+typedef unsigned long int shmatt_t;
+
 /* Data structure describing a set of semaphores.  */
 struct shmid_ds
   {
     struct ipc_perm shm_perm;		/* operation permission struct */
-    int shm_segsz;			/* size of segment in bytes */
+    size_t shm_segsz;			/* size of segment in bytes */
     __time_t shm_atime;			/* time of last shmat() */
     __time_t shm_dtime;			/* time of last shmdt() */
     __time_t shm_ctime;			/* time of last change by shmctl() */
-    long int shm_cpid;			/* pid of creator */
-    long int shm_lpid;			/* pid of last shmop */
-    unsigned short int shm_nattch;	/* number of current attaches */
-    unsigned short int __shm_npages;	/* size of segment (pages) */
-    unsigned long int *__unbounded __shm_pages;	/* array of ptrs to frames -> SHMMAX */
-    struct vm_area_struct *__unbounded __attaches; /* descriptors for attaches */
+    __pid_t shm_cpid;			/* pid of creator */
+    __pid_t shm_lpid;			/* pid of last shmop */
+    shmatt_t shm_nattch;		/* number of current attaches */
+    unsigned long int __unused1;
+    unsigned long int __unused2;
   };
 
 #ifdef __USE_MISC
@@ -62,23 +64,27 @@
 # define SHM_DEST	01000	/* segment will be destroyed on last detach */
 # define SHM_LOCKED	02000   /* segment will not be swapped */
 
-struct	shminfo
+struct shminfo
   {
-    int shmmax;
-    int shmmin;
-    int shmmni;
-    int shmseg;
-    int shmall;
+    unsigned long int shmmax;
+    unsigned long int shmmin;
+    unsigned long int shmmni;
+    unsigned long int shmseg;
+    unsigned long int shmall;
+    unsigned long int __unused1;
+    unsigned long int __unused2;
+    unsigned long int __unused3;
+    unsigned long int __unused4;
   };
 
 struct shm_info
   {
-    int   used_ids;
-    ulong shm_tot;	/* total allocated shm */
-    ulong shm_rss;	/* total resident shm */
-    ulong shm_swp;	/* total swapped shm */
-    ulong swap_attempts;
-    ulong swap_successes;
+    int used_ids;
+    unsigned long int shm_tot;  /* total allocated shm */
+    unsigned long int shm_rss;  /* total resident shm */
+    unsigned long int shm_swp;  /* total swapped shm */
+    unsigned long int swap_attempts;
+    unsigned long int swap_successes;
   };
 
 #endif /* __USE_MISC */
