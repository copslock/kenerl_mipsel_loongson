Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2014 19:43:04 +0100 (CET)
Received: from out01.mta.xmission.com ([166.70.13.231]:51726 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870549AbaAUSnBHNnAe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jan 2014 19:43:01 +0100
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <ebiederm@xmission.com>)
        id 1W5gHh-0004Ck-HM; Tue, 21 Jan 2014 11:42:49 -0700
Received: from c-98-207-154-105.hsd1.ca.comcast.net ([98.207.154.105] helo=eric-ThinkPad-X220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <ebiederm@xmission.com>)
        id 1W5gHe-0004J7-2I; Tue, 21 Jan 2014 11:42:49 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-arch@vger.kernel.org>, linux-mips@linux-mips.org
Date:   Tue, 21 Jan 2014 10:42:37 -0800
Message-ID: <8738kh6usi.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-AID: U2FsdGVkX1/Mk7+BjMfzAvohII6CWSpkNCni3ifinrk=
X-SA-Exim-Connect-IP: 98.207.154.105
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH] MIPS: VPE: Remove vpe_getuid and vpe_getgid
X-SA-Exim-Version: 4.2.1 (built Wed, 14 Nov 2012 14:26:46 -0700)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Return-Path: <ebiederm@xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


The linux build-bot recently reported a build error in arch/mips/kernel/vpe.c

     tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus
     head:   261000a56b6382f597bcb12000f55c9ff26a1efb
     commit: 261000a56b6382f597bcb12000f55c9ff26a1efb [4/4] userns:  userns: Remove UIDGID_STRICT_TYPE_CHECKS
     config: make ARCH=mips maltaaprp_defconfig

     All error/warnings:

        arch/mips/kernel/vpe.c: In function 'vpe_open':
     >> arch/mips/kernel/vpe.c:1086:9: error: incompatible types when assigning to type 'unsigned int' from type 'kuid_t'
     >> arch/mips/kernel/vpe.c:1087:9: error: incompatible types when assigning to type 'unsigned int' from type 'kgid_t'

     vim +1086 arch/mips/kernel/vpe.c

     863abad4 Jesper Juhl   2010-10-30  1080			return -ENOMEM;
     863abad4 Jesper Juhl   2010-10-30  1081  		}
     e01402b1 Ralf Baechle  2005-07-14  1082  		v->plen = P_SIZE;
     e01402b1 Ralf Baechle  2005-07-14  1083  		v->load_addr = NULL;
     e01402b1 Ralf Baechle  2005-07-14  1084  		v->len = 0;
     e01402b1 Ralf Baechle  2005-07-14  1085
     d76b0d9b David Howells 2008-11-14 @1086		v->uid = filp->f_cred->fsuid;
     d76b0d9b David Howells 2008-11-14 @1087  		v->gid = filp->f_cred->fsgid;
     2600990e Ralf Baechle  2006-04-05  1088
     2600990e Ralf Baechle  2006-04-05  1089		v->cwd[0] = 0;
     2600990e Ralf Baechle  2006-04-05  1090 	 	ret = getcwd(v->cwd, VPE_PATH_MAX);

When examining the code to see what v->uid and v->gid were used for I
discovered that the only users in the kernel are vpe_getuid and
vpe_getgid, and that vpe_getuid and vpe_getgid are never called.

So instead of proposing a conversion to use kuid_t and kgid_t instead
of unsigned int/int as I normally would let's just kill this dead code
so no one has to worry about it further.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/mips/include/asm/vpe.h |    2 --
 arch/mips/kernel/vpe.c      |   28 ----------------------------
 2 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
index c6e1b961537d..0880fe8809b1 100644
--- a/arch/mips/include/asm/vpe.h
+++ b/arch/mips/include/asm/vpe.h
@@ -30,8 +30,6 @@ struct vpe_notifications {
 extern int vpe_notify(int index, struct vpe_notifications *notify);
 
 extern void *vpe_get_shared(int index);
-extern int vpe_getuid(int index);
-extern int vpe_getgid(int index);
 extern char *vpe_getcwd(int index);
 
 #endif /* _ASM_VPE_H */
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 59b2b3cd7885..2d5c142bad67 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -105,7 +105,6 @@ struct vpe {
 	unsigned long len;
 	char *pbuffer;
 	unsigned long plen;
-	unsigned int uid, gid;
 	char cwd[VPE_PATH_MAX];
 
 	unsigned long __start;
@@ -1083,9 +1082,6 @@ static int vpe_open(struct inode *inode, struct file *filp)
 	v->load_addr = NULL;
 	v->len = 0;
 
-	v->uid = filp->f_cred->fsuid;
-	v->gid = filp->f_cred->fsgid;
-
 	v->cwd[0] = 0;
 	ret = getcwd(v->cwd, VPE_PATH_MAX);
 	if (ret < 0)
@@ -1269,30 +1265,6 @@ void *vpe_get_shared(int index)
 
 EXPORT_SYMBOL(vpe_get_shared);
 
-int vpe_getuid(int index)
-{
-	struct vpe *v;
-
-	if ((v = get_vpe(index)) == NULL)
-		return -1;
-
-	return v->uid;
-}
-
-EXPORT_SYMBOL(vpe_getuid);
-
-int vpe_getgid(int index)
-{
-	struct vpe *v;
-
-	if ((v = get_vpe(index)) == NULL)
-		return -1;
-
-	return v->gid;
-}
-
-EXPORT_SYMBOL(vpe_getgid);
-
 int vpe_notify(int index, struct vpe_notifications *notify)
 {
 	struct vpe *v;
-- 
1.7.5.4
