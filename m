Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 00:54:42 +0100 (CET)
Received: from mail333.us4.mandrillapp.com ([205.201.137.77]:58633 "EHLO
        mail333.us4.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007431AbcCAXyk09wtJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 00:54:40 +0100
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=mandrill; d=linuxfoundation.org;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=gregkh@linuxfoundation.org;
 bh=jXUWb+ZNafWuFCrhk0HuQZUJ4Fw=;
 b=EL5mYhxJ9XAZysQ6L4Iw8AS3dTxaMdxPnPwuybsf8fC8HqcoftjiirzJK7leMeQIj8m66ojyyG4O
   qXuG6nUV4mbaZACQ4efNItkacZ8G3oakTdjdS3R0zwG0a/WksZA6bw/Uflx0kXiuiZ56MzMtUCXb
   2bR4uQhGx0mDtKx06xo=
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=mandrill; d=linuxfoundation.org;
 b=bTnGA5RjVDZF8PBP+gbkdUI8Z02tFtjGPBOFOFCSj17KQ3/GLR/sRkfyD2z4BK29sYVNSaBy+4c6
   P5KwI6OYVsAWHnL4IA0jXaWWVLfV0Jt4ZKmpcnUkEYjg3mmdBQWqeuLbDjy9vqGl9sWPFuSzh4og
   HzINegBHaKqRxBZQJHU=;
Received: from pmta03.dal05.mailchimp.com (127.0.0.1) by mail333.us4.mandrillapp.com id hqols0174non for <linux-mips@linux-mips.org>; Tue, 1 Mar 2016 23:54:34 +0000 (envelope-from <bounce-md_30481620.56d62bba.v1-18e89a87add34809903f44b695655e92@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1456876474; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=ioGUREcHpYqDP2atzdku/ztJSEMFle5xDztXm2Fa/k0=; 
 b=SoJcFJXGSsqVB4tUD/ZBwxqEgAyKB1IDygvMLoBgXb8YNSZxQBzUFCIyjXw9Dlj2DeoY1E
 bNvm9di0/DLmxLytzihwWzfd5gDfAF9E059dvBJW24IsoJfoCISwGLFj3y9VQEm0BzjgIDGM
 acnyVLs9UFdh/8TtUGOvqd1dlLlQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 154/342] Revert "MIPS: Fix PAGE_MASK definition"
Received: from [50.170.35.168] by mandrillapp.com id 18e89a87add34809903f44b695655e92; Tue, 01 Mar 2016 23:54:34 +0000
X-Mailer: git-send-email 2.7.2
To:     <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>, Manuel Lauss <manuel.lauss@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Message-Id: <20160301234532.951366305@linuxfoundation.org>
In-Reply-To: <20160301234527.990448862@linuxfoundation.org>
References: <20160301234527.990448862@linuxfoundation.org>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=30481620.18e89a87add34809903f44b695655e92
X-Mandrill-User: md_30481620
Date:   Tue, 01 Mar 2016 23:54:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <bounce-md_30481620.56d62bba.v1-18e89a87add34809903f44b695655e92@mandrillapp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 800dc4f49cc002879e1e5e6b79926f86b60528e6 upstream.

This reverts commit 22b14523994588279ae9c5ccfe64073c1e5b3c00.

It was originally sent in an earlier revision of the pfn_t patchset.
Besides being broken, the warning is also fixed by PFN_FLAGS_MASK
casting the PAGE_MASK to an unsigned long.

Reported-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Patchwork: https://patchwork.linux-mips.org/patch/12182/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/page.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -33,7 +33,7 @@
 #define PAGE_SHIFT	16
 #endif
 #define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
 
 /*
  * This is used for calculating the real page sizes
