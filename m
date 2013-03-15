Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Mar 2013 02:58:00 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:41387 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6820301Ab3COB56e5Hh- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Mar 2013 02:57:58 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Thu, 14 Mar 2013 18:57:48 -0700
From:   Sanjay Lal <sanjayl@kymasys.com>
Content-Type: multipart/signed; boundary="Apple-Mail=_1705C600-26C6-4FD4-A666-7176C80767F6"; protocol="application/pgp-signature"; micalg=pgp-sha1
Subject: [PATCH] KVM/MIPS32: define KVM_USER_MEM_SLOTS
Date:   Thu, 14 Mar 2013 21:57:47 -0400
Message-Id: <1400666E-DC9B-4684-9F3E-206383108116@kymasys.com>
Cc:     kvm@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-mips@linux-mips.org
Mime-Version: 1.0 (Apple Message framework v1283)
X-Mailer: Apple Mail (2.1283)
X-archive-position: 35892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>


--Apple-Mail=_1705C600-26C6-4FD4-A666-7176C80767F6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


ARCH=3Dmips, config=3Dfuloong2e_defconfig:

akpm3:/usr/src/25> make arch/mips/kernel/early_printk.o
...
CC      arch/mips/kernel/asm-offsets.s
In file included from arch/mips/kernel/asm-offsets.c:20:
include/linux/kvm_host.h:334: error: `KVM_USER_MEM_SLOTS' undeclared =
here (not in a function)

Reported-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Gleb Natapov <gleb@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---

arch/mips/include/asm/kvm_host.h |    2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN =
arch/mips/include/asm/kvm_host.h~mips-define-kvm_user_mem_slots =
arch/mips/include/asm/kvm_host.h
--- a/arch/mips/include/asm/kvm_host.h~mips-define-kvm_user_mem_slots
+++ a/arch/mips/include/asm/kvm_host.h
@@ -21,7 +21,7 @@


#define KVM_MAX_VCPUS		1
-#define KVM_MEMORY_SLOTS	8
+#define KVM_USER_MEM_SLOTS	8
/* memory slots that does not exposed to userspace */
#define KVM_PRIVATE_MEM_SLOTS 	0



--Apple-Mail=_1705C600-26C6-4FD4-A666-7176C80767F6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)

iQIcBAEBAgAGBQJRQoAbAAoJECnL5VT5f2RtP9sP/j+EpsGjGV1qF3gtM0GFgG2G
iMNEfASSOByxZ0godlfuo9+AeorfCzErIqvUhzZ+DPWzZ3JJkyyTlPw83hjoThbL
iA9gi5gA2dG9B43g/Vzts/69bEnEoAOxnokjeT2BVpzQSJTYtAYwN0XhDtCWsoJZ
V1liogMbuuGQ58ypuuYn2rm4/ga506H7BkjEHlJ4tMDvCfs1z2XoRfYlqsaEO82r
hDEJILbHfRXgAVL8ugDPa8w0pJIppz2j3hnVC/+rBOSb8enfpqAiB7TPKZgegyIw
KyoxRusYuALlsUQdchj1wBLyOwcF28xIGLPubm1Sq1foXTBvf8qlPzq82QK5H6CF
C/0zidCito03TC7ANHgtfLmR4+UO1nQ1HVWti1S+9I/mw3CDBO5ksFYtc3ILErKm
ihlErpRUKz+k+CnSGJPPo4EllBpmgDE32ZWKKZpZgnl8b9oVz6SiCmay5gsSjoQr
jFYUlOZwbeFpLPedQ6faB7rMCj9UE4vokgX1Gs/52ZhZxrcl5m7SyuqS/wviurNn
NoQ5EyYViQZ98cgZHLhD04frgYgYInBkUXNG09CrDgGpVkr/mtY7jj1/EwAnx9mM
A9teOYRoIisvY3oXVKkwOzPMIq85/7s72t8ZEuvNMc7+3OWAtvivFyC6k6veIa0O
3tXW/aFwWOaQfU/OrInH
=3HU9
-----END PGP SIGNATURE-----

--Apple-Mail=_1705C600-26C6-4FD4-A666-7176C80767F6--
