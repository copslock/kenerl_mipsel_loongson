Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2002 16:05:52 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:57287 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123897AbSJBOFv>;
	Wed, 2 Oct 2002 16:05:51 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g92E52rZ006874;
	Wed, 2 Oct 2002 07:05:02 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA23475;
	Wed, 2 Oct 2002 07:05:31 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g92E53b06433;
	Wed, 2 Oct 2002 16:05:03 +0200 (MEST)
Message-ID: <3D9AFD0E.84BA5100@mips.com>
Date: Wed, 02 Oct 2002 16:05:02 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit kernel patch.
References: <Pine.GSO.3.96.1021002153025.8947A-100000@delta.ds2.pg.gda.pl>
Content-Type: multipart/mixed;
 boundary="------------4DF78B00319C7D722D09F588"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------4DF78B00319C7D722D09F588
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Ok, here is the next patch.
It fixes the sys32_sendmsg and sys32_recvmsg.

/Carsten


"Maciej W. Rozycki" wrote:

> On Wed, 2 Oct 2002, Carsten Langgaard wrote:
>
> > I have a number of patches for the o32 syscall wrapper/conversion
> > routines, which is needed when running a 64-bit kernel on an o32
> > userland.
> > Here is the first one. Ralf, could you please apply it, so I can send
> > the next one.
>
>  Do you have a fix for sys32_sendmsg/sys32_recvmsg as well?  I just
> started working on it and I'd prefer not to do a duplicate work.
>
>  As a side note -- arch/mips64/kernel/linux32.c is a huge collection of
> often unrelated functions.  It might be beneficial to split the file
> functionally, e.g. into fs32.c, net32.c, etc. or even with a finer grain,
> preferably in a subdirectory, e.g. arch/mips64/linux32/.  What do you
> think?
>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------4DF78B00319C7D722D09F588
Content-Type: text/plain; charset=iso-8859-15;
 name="syscall_wrapper.part2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syscall_wrapper.part2.patch"

Index: arch/mips64/kernel/linux32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/linux32.c,v
retrieving revision 1.42.2.13
diff -u -r1.42.2.13 linux32.c
--- arch/mips64/kernel/linux32.c	2 Oct 2002 13:32:45 -0000	1.42.2.13
+++ arch/mips64/kernel/linux32.c	2 Oct 2002 13:55:08 -0000
@@ -32,6 +32,7 @@
 #include <linux/dnotify.h>
 #include <linux/module.h>
 #include <net/sock.h>
+#include <net/scm.h>
 
 #include <asm/uaccess.h>
 #include <asm/mman.h>
@@ -1712,6 +1713,7 @@
 	return err;
 }
 
+static int
 do_sys32_msgsnd (int first, int second, int third, void *uptr)
 {
 	struct msgbuf32 *up = (struct msgbuf32 *)uptr;
@@ -2244,7 +2246,7 @@
 /*
  *  Declare the 32-bit version of the msghdr
  */
-
+ 
 struct msghdr32 {
 	unsigned int    msg_name;	/* Socket name			*/
 	int		msg_namelen;	/* Length of name		*/
@@ -2255,74 +2257,132 @@
 	unsigned	msg_flags;
 };
 
-static inline int
-shape_msg(struct msghdr *mp, struct msghdr32 *mp32)
+struct cmsghdr32 {
+        __kernel_size_t32 cmsg_len;
+        int               cmsg_level;
+        int               cmsg_type;
+};
+
+/* Bleech... */
+#define __CMSG32_NXTHDR(ctl, len, cmsg, cmsglen) __cmsg32_nxthdr((ctl),(len),(cmsg),(cmsglen))
+#define CMSG32_NXTHDR(mhdr, cmsg, cmsglen) cmsg32_nxthdr((mhdr), (cmsg), (cmsglen))
+
+#define CMSG32_ALIGN(len) ( ((len)+sizeof(int)-1) & ~(sizeof(int)-1) )
+
+#define CMSG32_DATA(cmsg)	((void *)((char *)(cmsg) + CMSG32_ALIGN(sizeof(struct cmsghdr32))))
+#define CMSG32_SPACE(len) (CMSG32_ALIGN(sizeof(struct cmsghdr32)) + CMSG32_ALIGN(len))
+#define CMSG32_LEN(len) (CMSG32_ALIGN(sizeof(struct cmsghdr32)) + (len))
+
+#define __CMSG32_FIRSTHDR(ctl,len) ((len) >= sizeof(struct cmsghdr32) ? \
+				    (struct cmsghdr32 *)(ctl) : \
+				    (struct cmsghdr32 *)NULL)
+#define CMSG32_FIRSTHDR(msg)	__CMSG32_FIRSTHDR((msg)->msg_control, (msg)->msg_controllen)
+
+__inline__ struct cmsghdr32 *__cmsg32_nxthdr(void *__ctl, __kernel_size_t __size,
+					      struct cmsghdr32 *__cmsg, int __cmsg_len)
 {
-	int ret;
-	unsigned int i;
+	struct cmsghdr32 * __ptr;
 
-	if (!access_ok(VERIFY_READ, mp32, sizeof(*mp32)))
-		return(-EFAULT);
-	ret = __get_user(i, &mp32->msg_name);
-	mp->msg_name = (void *)A(i);
-	ret |= __get_user(mp->msg_namelen, &mp32->msg_namelen);
-	ret |= __get_user(i, &mp32->msg_iov);
-	mp->msg_iov = (struct iovec *)A(i);
-	ret |= __get_user(mp->msg_iovlen, &mp32->msg_iovlen);
-	ret |= __get_user(i, &mp32->msg_control);
-	mp->msg_control = (void *)A(i);
-	ret |= __get_user(mp->msg_controllen, &mp32->msg_controllen);
-	ret |= __get_user(mp->msg_flags, &mp32->msg_flags);
-	return(ret ? -EFAULT : 0);
+	__ptr = (struct cmsghdr32 *)(((unsigned char *) __cmsg) +
+				     CMSG32_ALIGN(__cmsg_len));
+	if ((unsigned long)((char*)(__ptr+1) - (char *) __ctl) > __size)
+		return NULL;
+
+	return __ptr;
 }
 
-/*
- *	Verify & re-shape IA32 iovec. The caller must ensure that the
- *      iovec is big enough to hold the re-shaped message iovec.
- *
- *	Save time not doing verify_area. copy_*_user will make this work
- *	in any case.
- *
- *	Don't need to check the total size for overflow (cf net/core/iovec.c),
- *	32-bit sizes can't overflow a 64-bit count.
- */
+__inline__ struct cmsghdr32 *cmsg32_nxthdr (struct msghdr *__msg,
+					    struct cmsghdr32 *__cmsg,
+					    int __cmsg_len)
+{
+	return __cmsg32_nxthdr(__msg->msg_control, __msg->msg_controllen,
+			       __cmsg, __cmsg_len);
+}
 
-static inline int
-verify_iovec32(struct msghdr *m, struct iovec *iov, char *address, int mode)
+static inline int iov_from_user32_to_kern(struct iovec *kiov,
+					  struct iovec32 *uiov32,
+					  int niov)
 {
-	int size, err, ct;
-	struct iovec32 *iov32;
+	int tot_len = 0;
 
-	if(m->msg_namelen)
-	{
-		if(mode==VERIFY_READ)
-		{
-			err=move_addr_to_kernel(m->msg_name, m->msg_namelen, address);
-			if(err<0)
-				goto out;
+	while(niov > 0) {
+		u32 len, buf;
+
+		if(get_user(len, &uiov32->iov_len) ||
+		   get_user(buf, &uiov32->iov_base)) {
+			tot_len = -EFAULT;
+			break;
 		}
+		tot_len += len;
+		kiov->iov_base = (void *)AA(buf);
+		kiov->iov_len = (__kernel_size_t) len;
+		uiov32++;
+		kiov++;
+		niov--;
+	}
+	return tot_len;
+}
 
-		m->msg_name = address;
-	} else
-		m->msg_name = NULL;
+static inline int msghdr_from_user32_to_kern(struct msghdr *kmsg,
+					     struct msghdr32 *umsg)
+{
+	u32 tmp1, tmp2, tmp3;
+	int err;
 
-	err = -EFAULT;
-	size = m->msg_iovlen * sizeof(struct iovec32);
-	if (copy_from_user(iov, m->msg_iov, size))
-		goto out;
-	m->msg_iov=iov;
+	err = get_user(tmp1, &umsg->msg_name);
+	err |= __get_user(tmp2, &umsg->msg_iov);
+	err |= __get_user(tmp3, &umsg->msg_control);
+	if (err)
+		return -EFAULT;
 
-	err = 0;
-	iov32 = (struct iovec32 *)iov;
-	for (ct = m->msg_iovlen; ct-- > 0; ) {
-		iov[ct].iov_len = (__kernel_size_t)iov32[ct].iov_len;
-		iov[ct].iov_base = (void *) A(iov32[ct].iov_base);
-		err += iov[ct].iov_len;
-	}
-out:
+	kmsg->msg_name = (void *)AA(tmp1);
+	kmsg->msg_iov = (struct iovec *)AA(tmp2);
+	kmsg->msg_control = (void *)AA(tmp3);
+
+	err = get_user(kmsg->msg_namelen, &umsg->msg_namelen);
+	err |= get_user(kmsg->msg_iovlen, &umsg->msg_iovlen);
+	err |= get_user(kmsg->msg_controllen, &umsg->msg_controllen);
+	err |= get_user(kmsg->msg_flags, &umsg->msg_flags);
+	
 	return err;
 }
 
+/* I've named the args so it is easy to tell whose space the pointers are in. */
+static int verify_iovec32(struct msghdr *kern_msg, struct iovec *kern_iov,
+			  char *kern_address, int mode)
+{
+	int tot_len;
+
+	if(kern_msg->msg_namelen) {
+		if(mode==VERIFY_READ) {
+			int err = move_addr_to_kernel(kern_msg->msg_name,
+						      kern_msg->msg_namelen,
+						      kern_address);
+			if(err < 0)
+				return err;
+		}
+		kern_msg->msg_name = kern_address;
+	} else
+		kern_msg->msg_name = NULL;
+
+	if(kern_msg->msg_iovlen > UIO_FASTIOV) {
+		kern_iov = kmalloc(kern_msg->msg_iovlen * sizeof(struct iovec),
+				   GFP_KERNEL);
+		if(!kern_iov)
+			return -ENOMEM;
+	}
+
+	tot_len = iov_from_user32_to_kern(kern_iov,
+					  (struct iovec32 *)kern_msg->msg_iov,
+					  kern_msg->msg_iovlen);
+	if(tot_len >= 0)
+		kern_msg->msg_iov = kern_iov;
+	else if(kern_msg->msg_iovlen > UIO_FASTIOV)
+		kfree(kern_iov);
+
+	return tot_len;
+}
+
 extern __inline__ void
 sockfd_put(struct socket *sock)
 {
@@ -2330,177 +2390,385 @@
 }
 
 /* XXX This really belongs in some header file... -DaveM */
-#define MAX_SOCK_ADDR	128		/* 108 for Unix domain -
+#define MAX_SOCK_ADDR	128		/* 108 for Unix domain - 
 					   16 for IP, 16 for IPX,
 					   24 for IPv6,
 					   about 80 for AX.25 */
 
 extern struct socket *sockfd_lookup(int fd, int *err);
 
-/*
- *	BSD sendmsg interface
+/* There is a lot of hair here because the alignment rules (and
+ * thus placement) of cmsg headers and length are different for
+ * 32-bit apps.  -DaveM
  */
-
-int sys32_sendmsg(int fd, struct msghdr32 *msg, unsigned flags)
+static int cmsghdr_from_user32_to_kern(struct msghdr *kmsg,
+				       unsigned char *stackbuf, int stackbuf_size)
 {
-	struct socket *sock;
-	char address[MAX_SOCK_ADDR];
-	struct iovec iovstack[UIO_FASTIOV], *iov = iovstack;
-	unsigned char ctl[sizeof(struct cmsghdr) + 20];	/* 20 is size of ipv6_pktinfo */
-	unsigned char *ctl_buf = ctl;
-	struct msghdr msg_sys;
-	int err, ctl_len, iov_size, total_len;
+	struct cmsghdr32 *ucmsg;
+	struct cmsghdr *kcmsg, *kcmsg_base;
+	__kernel_size_t32 ucmlen;
+	__kernel_size_t kcmlen, tmp;
+
+	kcmlen = 0;
+	kcmsg_base = kcmsg = (struct cmsghdr *)stackbuf;
+	ucmsg = CMSG32_FIRSTHDR(kmsg);
+	while(ucmsg != NULL) {
+		if(get_user(ucmlen, &ucmsg->cmsg_len))
+			return -EFAULT;
 
-	err = -EFAULT;
-	if (shape_msg(&msg_sys, msg))
-		goto out;
+		/* Catch bogons. */
+		if(CMSG32_ALIGN(ucmlen) <
+		   CMSG32_ALIGN(sizeof(struct cmsghdr32)))
+			return -ENOBUFS;
+		if((unsigned long)(((char *)ucmsg - (char *)kmsg->msg_control)
+				   + ucmlen) > kmsg->msg_controllen)
+			return -EINVAL;
+
+		tmp = ((ucmlen - CMSG32_ALIGN(sizeof(*ucmsg))) +
+		       CMSG_ALIGN(sizeof(struct cmsghdr)));
+		kcmlen += tmp;
+		ucmsg = CMSG32_NXTHDR(kmsg, ucmsg, ucmlen);
+	}
+	if(kcmlen == 0)
+		return -EINVAL;
 
-	sock = sockfd_lookup(fd, &err);
-	if (!sock)
-		goto out;
+	/* The kcmlen holds the 64-bit version of the control length.
+	 * It may not be modified as we do not stick it into the kmsg
+	 * until we have successfully copied over all of the data
+	 * from the user.
+	 */
+	if(kcmlen > stackbuf_size)
+		kcmsg_base = kcmsg = kmalloc(kcmlen, GFP_KERNEL);
+	if(kcmsg == NULL)
+		return -ENOBUFS;
+
+	/* Now copy them over neatly. */
+	memset(kcmsg, 0, kcmlen);
+	ucmsg = CMSG32_FIRSTHDR(kmsg);
+	while(ucmsg != NULL) {
+		__get_user(ucmlen, &ucmsg->cmsg_len);
+		tmp = ((ucmlen - CMSG32_ALIGN(sizeof(*ucmsg))) +
+		       CMSG_ALIGN(sizeof(struct cmsghdr)));
+		kcmsg->cmsg_len = tmp;
+		__get_user(kcmsg->cmsg_level, &ucmsg->cmsg_level);
+		__get_user(kcmsg->cmsg_type, &ucmsg->cmsg_type);
+
+		/* Copy over the data. */
+		if(copy_from_user(CMSG_DATA(kcmsg),
+				  CMSG32_DATA(ucmsg),
+				  (ucmlen - CMSG32_ALIGN(sizeof(*ucmsg)))))
+			goto out_free_efault;
+
+		/* Advance. */
+		kcmsg = (struct cmsghdr *)((char *)kcmsg + CMSG_ALIGN(tmp));
+		ucmsg = CMSG32_NXTHDR(kmsg, ucmsg, ucmlen);
+	}
+
+	/* Ok, looks like we made it.  Hook it up and return success. */
+	kmsg->msg_control = kcmsg_base;
+	kmsg->msg_controllen = kcmlen;
+	return 0;
 
-	/* do not move before msg_sys is valid */
-	err = -EINVAL;
-	if (msg_sys.msg_iovlen > UIO_MAXIOV)
-		goto out_put;
+out_free_efault:
+	if(kcmsg_base != (struct cmsghdr *)stackbuf)
+		kfree(kcmsg_base);
+	return -EFAULT;
+}
 
-	/* Check whether to allocate the iovec area*/
-	err = -ENOMEM;
-	iov_size = msg_sys.msg_iovlen * sizeof(struct iovec32);
-	if (msg_sys.msg_iovlen > UIO_FASTIOV) {
-		iov = sock_kmalloc(sock->sk, iov_size, GFP_KERNEL);
-		if (!iov)
-			goto out_put;
+static void put_cmsg32(struct msghdr *kmsg, int level, int type,
+		       int len, void *data)
+{
+	struct cmsghdr32 *cm = (struct cmsghdr32 *) kmsg->msg_control;
+	struct cmsghdr32 cmhdr;
+	int cmlen = CMSG32_LEN(len);
+
+	if(cm == NULL || kmsg->msg_controllen < sizeof(*cm)) {
+		kmsg->msg_flags |= MSG_CTRUNC;
+		return;
 	}
 
-	/* This will also move the address data into kernel space */
-	err = verify_iovec32(&msg_sys, iov, address, VERIFY_READ);
-	if (err < 0)
-		goto out_freeiov;
-	total_len = err;
+	if(kmsg->msg_controllen < cmlen) {
+		kmsg->msg_flags |= MSG_CTRUNC;
+		cmlen = kmsg->msg_controllen;
+	}
+	cmhdr.cmsg_level = level;
+	cmhdr.cmsg_type = type;
+	cmhdr.cmsg_len = cmlen;
 
-	err = -ENOBUFS;
+	if(copy_to_user(cm, &cmhdr, sizeof cmhdr))
+		return;
+	if(copy_to_user(CMSG32_DATA(cm), data, cmlen - sizeof(struct cmsghdr32)))
+		return;
+	cmlen = CMSG32_SPACE(len);
+	kmsg->msg_control += cmlen;
+	kmsg->msg_controllen -= cmlen;
+}
+
+static void scm_detach_fds32(struct msghdr *kmsg, struct scm_cookie *scm)
+{
+	struct cmsghdr32 *cm = (struct cmsghdr32 *) kmsg->msg_control;
+	int fdmax = (kmsg->msg_controllen - sizeof(struct cmsghdr32)) / sizeof(int);
+	int fdnum = scm->fp->count;
+	struct file **fp = scm->fp->fp;
+	int *cmfptr;
+	int err = 0, i;
+
+	if (fdnum < fdmax)
+		fdmax = fdnum;
+
+	for (i = 0, cmfptr = (int *) CMSG32_DATA(cm); i < fdmax; i++, cmfptr++) {
+		int new_fd;
+		err = get_unused_fd();
+		if (err < 0)
+			break;
+		new_fd = err;
+		err = put_user(new_fd, cmfptr);
+		if (err) {
+			put_unused_fd(new_fd);
+			break;
+		}
+		/* Bump the usage count and install the file. */
+		get_file(fp[i]);
+		fd_install(new_fd, fp[i]);
+	}
 
-	if (msg_sys.msg_controllen > INT_MAX)
-		goto out_freeiov;
-	ctl_len = msg_sys.msg_controllen;
-	if (ctl_len)
-	{
-		if (ctl_len > sizeof(ctl))
-		{
-			err = -ENOBUFS;
-			ctl_buf = sock_kmalloc(sock->sk, ctl_len, GFP_KERNEL);
-			if (ctl_buf == NULL)
-				goto out_freeiov;
+	if (i > 0) {
+		int cmlen = CMSG32_LEN(i * sizeof(int));
+		if (!err)
+			err = put_user(SOL_SOCKET, &cm->cmsg_level);
+		if (!err)
+			err = put_user(SCM_RIGHTS, &cm->cmsg_type);
+		if (!err)
+			err = put_user(cmlen, &cm->cmsg_len);
+		if (!err) {
+			cmlen = CMSG32_SPACE(i * sizeof(int));
+			kmsg->msg_control += cmlen;
+			kmsg->msg_controllen -= cmlen;
 		}
-		err = -EFAULT;
-		if (copy_from_user(ctl_buf, msg_sys.msg_control, ctl_len))
-			goto out_freectl;
-		msg_sys.msg_control = ctl_buf;
-	}
-	msg_sys.msg_flags = flags;
-
-	if (sock->file->f_flags & O_NONBLOCK)
-		msg_sys.msg_flags |= MSG_DONTWAIT;
-	err = sock_sendmsg(sock, &msg_sys, total_len);
-
-out_freectl:
-	if (ctl_buf != ctl)
-		sock_kfree_s(sock->sk, ctl_buf, ctl_len);
-out_freeiov:
-	if (iov != iovstack)
-		sock_kfree_s(sock->sk, iov, iov_size);
-out_put:
-	sockfd_put(sock);
-out:
-	return err;
+	}
+	if (i < fdnum)
+		kmsg->msg_flags |= MSG_CTRUNC;
+
+	/*
+	 * All of the files that fit in the message have had their
+	 * usage counts incremented, so we just free the list.
+	 */
+	__scm_destroy(scm);
 }
 
-/*
- *	BSD recvmsg interface
+/* In these cases we (currently) can just copy to data over verbatim
+ * because all CMSGs created by the kernel have well defined types which
+ * have the same layout in both the 32-bit and 64-bit API.  One must add
+ * some special cased conversions here if we start sending control messages
+ * with incompatible types.
+ *
+ * SCM_RIGHTS and SCM_CREDENTIALS are done by hand in recvmsg32 right after
+ * we do our work.  The remaining cases are:
+ *
+ * SOL_IP	IP_PKTINFO	struct in_pktinfo	32-bit clean
+ *		IP_TTL		int			32-bit clean
+ *		IP_TOS		__u8			32-bit clean
+ *		IP_RECVOPTS	variable length		32-bit clean
+ *		IP_RETOPTS	variable length		32-bit clean
+ *		(these last two are clean because the types are defined
+ *		 by the IPv4 protocol)
+ *		IP_RECVERR	struct sock_extended_err +
+ *				struct sockaddr_in	32-bit clean
+ * SOL_IPV6	IPV6_RECVERR	struct sock_extended_err +
+ *				struct sockaddr_in6	32-bit clean
+ *		IPV6_PKTINFO	struct in6_pktinfo	32-bit clean
+ *		IPV6_HOPLIMIT	int			32-bit clean
+ *		IPV6_FLOWINFO	u32			32-bit clean
+ *		IPV6_HOPOPTS	ipv6 hop exthdr		32-bit clean
+ *		IPV6_DSTOPTS	ipv6 dst exthdr(s)	32-bit clean
+ *		IPV6_RTHDR	ipv6 routing exthdr	32-bit clean
+ *		IPV6_AUTHHDR	ipv6 auth exthdr	32-bit clean
  */
-
-int
-sys32_recvmsg (int fd, struct msghdr32 *msg, unsigned int flags)
+static void cmsg32_recvmsg_fixup(struct msghdr *kmsg, unsigned long orig_cmsg_uptr)
 {
-	struct socket *sock;
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov=iovstack;
-	struct msghdr msg_sys;
-	unsigned long cmsg_ptr;
-	int err, iov_size, total_len, len;
+	unsigned char *workbuf, *wp;
+	unsigned long bufsz, space_avail;
+	struct cmsghdr *ucmsg;
+
+	bufsz = ((unsigned long)kmsg->msg_control) - orig_cmsg_uptr;
+	space_avail = kmsg->msg_controllen + bufsz;
+	wp = workbuf = kmalloc(bufsz, GFP_KERNEL);
+	if(workbuf == NULL)
+		goto fail;
+
+	/* To make this more sane we assume the kernel sends back properly
+	 * formatted control messages.  Because of how the kernel will truncate
+	 * the cmsg_len for MSG_TRUNC cases, we need not check that case either.
+	 */
+	ucmsg = (struct cmsghdr *) orig_cmsg_uptr;
+	while(((unsigned long)ucmsg) <=
+	      (((unsigned long)kmsg->msg_control) - sizeof(struct cmsghdr))) {
+		struct cmsghdr32 *kcmsg32 = (struct cmsghdr32 *) wp;
+		int clen64, clen32;
+
+		/* UCMSG is the 64-bit format CMSG entry in user-space.
+		 * KCMSG32 is within the kernel space temporary buffer
+		 * we use to convert into a 32-bit style CMSG.
+		 */
+		__get_user(kcmsg32->cmsg_len, &ucmsg->cmsg_len);
+		__get_user(kcmsg32->cmsg_level, &ucmsg->cmsg_level);
+		__get_user(kcmsg32->cmsg_type, &ucmsg->cmsg_type);
+
+		clen64 = kcmsg32->cmsg_len;
+		copy_from_user(CMSG32_DATA(kcmsg32), CMSG_DATA(ucmsg),
+			       clen64 - CMSG_ALIGN(sizeof(*ucmsg)));
+		clen32 = ((clen64 - CMSG_ALIGN(sizeof(*ucmsg))) +
+			  CMSG32_ALIGN(sizeof(struct cmsghdr32)));
+		kcmsg32->cmsg_len = clen32;
+
+		ucmsg = (struct cmsghdr *) (((char *)ucmsg) + CMSG_ALIGN(clen64));
+		wp = (((char *)kcmsg32) + CMSG32_ALIGN(clen32));
+	}
+
+	/* Copy back fixed up data, and adjust pointers. */
+	bufsz = (wp - workbuf);
+	copy_to_user((void *)orig_cmsg_uptr, workbuf, bufsz);
+
+	kmsg->msg_control = (struct cmsghdr *)
+		(((char *)orig_cmsg_uptr) + bufsz);
+	kmsg->msg_controllen = space_avail - bufsz;
 
-	/* kernel mode address */
-	char addr[MAX_SOCK_ADDR];
+	kfree(workbuf);
+	return;
 
-	/* user mode address pointers */
-	struct sockaddr *uaddr;
-	int *uaddr_len;
+fail:
+	/* If we leave the 64-bit format CMSG chunks in there,
+	 * the application could get confused and crash.  So to
+	 * ensure greater recovery, we report no CMSGs.
+	 */
+	kmsg->msg_controllen += bufsz;
+	kmsg->msg_control = (void *) orig_cmsg_uptr;
+}
 
-	err=-EFAULT;
-	if (shape_msg(&msg_sys, msg))
-		goto out;
+asmlinkage int sys32_sendmsg(int fd, struct msghdr32 *user_msg, unsigned user_flags)
+{
+	struct socket *sock;
+	char address[MAX_SOCK_ADDR];
+	struct iovec iov[UIO_FASTIOV];
+	unsigned char ctl[sizeof(struct cmsghdr) + 20];
+	unsigned char *ctl_buf = ctl;
+	struct msghdr kern_msg;
+	int err, total_len;
 
-	sock = sockfd_lookup(fd, &err);
-	if (!sock)
+	if(msghdr_from_user32_to_kern(&kern_msg, user_msg))
+		return -EFAULT;
+	if(kern_msg.msg_iovlen > UIO_MAXIOV)
+		return -EINVAL;
+	err = verify_iovec32(&kern_msg, iov, address, VERIFY_READ);
+	if (err < 0)
 		goto out;
+	total_len = err;
 
-	err = -EINVAL;
-	if (msg_sys.msg_iovlen > UIO_MAXIOV)
-		goto out_put;
+	if(kern_msg.msg_controllen) {
+		err = cmsghdr_from_user32_to_kern(&kern_msg, ctl, sizeof(ctl));
+		if(err)
+			goto out_freeiov;
+		ctl_buf = kern_msg.msg_control;
+	}
+	kern_msg.msg_flags = user_flags;
 
-	/* Check whether to allocate the iovec area*/
-	err = -ENOMEM;
-	iov_size = msg_sys.msg_iovlen * sizeof(struct iovec);
-	if (msg_sys.msg_iovlen > UIO_FASTIOV) {
-		iov = sock_kmalloc(sock->sk, iov_size, GFP_KERNEL);
-		if (!iov)
-			goto out_put;
+	sock = sockfd_lookup(fd, &err);
+	if (sock != NULL) {
+		if (sock->file->f_flags & O_NONBLOCK)
+			kern_msg.msg_flags |= MSG_DONTWAIT;
+		err = sock_sendmsg(sock, &kern_msg, total_len);
+		sockfd_put(sock);
 	}
 
-	/*
-	 *	Save the user-mode address (verify_iovec will change the
-	 *	kernel msghdr to use the kernel address space)
-	 */
+	/* N.B. Use kfree here, as kern_msg.msg_controllen might change? */
+	if(ctl_buf != ctl)
+		kfree(ctl_buf);
+out_freeiov:
+	if(kern_msg.msg_iov != iov)
+		kfree(kern_msg.msg_iov);
+out:
+	return err;
+}
 
-	uaddr = msg_sys.msg_name;
-	uaddr_len = &msg->msg_namelen;
-	err = verify_iovec32(&msg_sys, iov, addr, VERIFY_WRITE);
-	if (err < 0)
-		goto out_freeiov;
-	total_len=err;
+asmlinkage int sys32_recvmsg(int fd, struct msghdr32 *user_msg, unsigned int user_flags)
+{
+	struct iovec iovstack[UIO_FASTIOV];
+	struct msghdr kern_msg;
+	char addr[MAX_SOCK_ADDR];
+	struct socket *sock;
+	struct iovec *iov = iovstack;
+	struct sockaddr *uaddr;
+	int *uaddr_len;
+	unsigned long cmsg_ptr;
+	int err, total_len, len = 0;
 
-	cmsg_ptr = (unsigned long)msg_sys.msg_control;
-	msg_sys.msg_flags = 0;
+	if(msghdr_from_user32_to_kern(&kern_msg, user_msg))
+		return -EFAULT;
+	if(kern_msg.msg_iovlen > UIO_MAXIOV)
+		return -EINVAL;
 
-	if (sock->file->f_flags & O_NONBLOCK)
-		flags |= MSG_DONTWAIT;
-	err = sock_recvmsg(sock, &msg_sys, total_len, flags);
+	uaddr = kern_msg.msg_name;
+	uaddr_len = &user_msg->msg_namelen;
+	err = verify_iovec32(&kern_msg, iov, addr, VERIFY_WRITE);
 	if (err < 0)
-		goto out_freeiov;
-	len = err;
+		goto out;
+	total_len = err;
 
-	if (uaddr != NULL) {
-		err = move_addr_to_user(addr, msg_sys.msg_namelen, uaddr, uaddr_len);
-		if (err < 0)
-			goto out_freeiov;
+	cmsg_ptr = (unsigned long) kern_msg.msg_control;
+	kern_msg.msg_flags = 0;
+
+	sock = sockfd_lookup(fd, &err);
+	if (sock != NULL) {
+		struct scm_cookie scm;
+
+		if (sock->file->f_flags & O_NONBLOCK)
+			user_flags |= MSG_DONTWAIT;
+		memset(&scm, 0, sizeof(scm));
+		err = sock->ops->recvmsg(sock, &kern_msg, total_len,
+					 user_flags, &scm);
+		if(err >= 0) {
+			len = err;
+			if(!kern_msg.msg_control) {
+				if(sock->passcred || scm.fp)
+					kern_msg.msg_flags |= MSG_CTRUNC;
+				if(scm.fp)
+					__scm_destroy(&scm);
+			} else {
+				/* If recvmsg processing itself placed some
+				 * control messages into user space, it's is
+				 * using 64-bit CMSG processing, so we need
+				 * to fix it up before we tack on more stuff.
+				 */
+				if((unsigned long) kern_msg.msg_control != cmsg_ptr)
+					cmsg32_recvmsg_fixup(&kern_msg, cmsg_ptr);
+
+				/* Wheee... */
+				if(sock->passcred)
+					put_cmsg32(&kern_msg,
+						   SOL_SOCKET, SCM_CREDENTIALS,
+						   sizeof(scm.creds), &scm.creds);
+				if(scm.fp != NULL)
+					scm_detach_fds32(&kern_msg, &scm);
+			}
+		}
+		sockfd_put(sock);
 	}
-	err = __put_user(msg_sys.msg_flags, &msg->msg_flags);
-	if (err)
-		goto out_freeiov;
-	err = __put_user((unsigned long)msg_sys.msg_control-cmsg_ptr,
-							 &msg->msg_controllen);
-	if (err)
-		goto out_freeiov;
-	err = len;
 
-out_freeiov:
-	if (iov != iovstack)
-		sock_kfree_s(sock->sk, iov, iov_size);
-out_put:
-	sockfd_put(sock);
+	if(uaddr != NULL && kern_msg.msg_namelen && err >= 0)
+		err = move_addr_to_user(addr, kern_msg.msg_namelen, uaddr, uaddr_len);
+	if(cmsg_ptr != 0 && err >= 0) {
+		unsigned long ucmsg_ptr = ((unsigned long)kern_msg.msg_control);
+		__kernel_size_t32 uclen = (__kernel_size_t32) (ucmsg_ptr - cmsg_ptr);
+		err |= __put_user(uclen, &user_msg->msg_controllen);
+	}
+	if(err >= 0)
+		err = __put_user(kern_msg.msg_flags, &user_msg->msg_flags);
+	if(kern_msg.msg_iov != iov)
+		kfree(kern_msg.msg_iov);
 out:
-	return err;
+	if(err < 0)
+		return err;
+	return len;
 }
 
 asmlinkage ssize_t sys_readahead(int fd, loff_t offset, size_t count);

--------------4DF78B00319C7D722D09F588--
