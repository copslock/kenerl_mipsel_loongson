Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2014 03:25:56 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:44384 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855122AbaHOBZkXwDoi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Aug 2014 03:25:40 +0200
Received: by mail-pd0-f177.google.com with SMTP id p10so2489055pdj.8
        for <multiple recipients>; Thu, 14 Aug 2014 18:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=/6zf3D4Ih6dfHuLdyxDcep0ykhMuWPtXTUKNOOnGnw0=;
        b=KySmjueBfoQWlsUyz0Oy/2sNik7PndzeCpk7hyr+cRNjFHpxk7ddYKFl8LMYT9IX5L
         Kd0xyBs7ngq98T/c2RNMahsUwVxMyCjJKiho+eGf/1NHTf53lJw+tZ4f2ka3cwRhfrR1
         hwZg7E/IutfmPBputyXtRbtzvUNzJ/3yD9RAx+dHiWM2n9qzy3Dr4FLo6aFbYoz7NDXE
         fM4XvRZo9LeKO3QK3ygSL19yo7bH2IeCgazx/kwqr5QBhJaazKStpDhRar78Jn6r2nxV
         0igRBspIJNGNcEDApx7j/vPZhS9MQ43DNxda1/pBs17U+UPHFM0qBJ4Q2S5RH6Filsev
         rtLQ==
X-Received: by 10.66.152.131 with SMTP id uy3mr8084069pab.13.1408065933769;
        Thu, 14 Aug 2014 18:25:33 -0700 (PDT)
Received: from ShengShiZhuChengdeMacBook-Pro.local ([219.143.82.150])
        by mx.google.com with ESMTPSA id fa7sm9793882pdb.57.2014.08.14.18.25.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Aug 2014 18:25:33 -0700 (PDT)
Message-ID: <53ED628D.8010807@gmail.com>
Date:   Fri, 15 Aug 2014 09:29:49 +0800
From:   Chen Gang <gang.chen.5i5j@gmail.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Lennox Wu <lennox.wu@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rth@twiddle.net" <rth@twiddle.net>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean Delvare <jdelvare@suse.de>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>,
        "egtvedt@samfundet.no" <egtvedt@samfundet.no>,
        "realmz6@gmail.com" <realmz6@gmail.com>,
        "msalter@redhat.com" <msalter@redhat.com>,
        "a-jacquiot@ti.com" <a-jacquiot@ti.com>,
        "starvik@axis.com" <starvik@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "rkuo@codeaurora.org" <rkuo@codeaurora.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "takata@linux-m32r.org" <takata@linux-m32r.org>,
        "james.hogan@imgtec.com" <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "yasutake.koichi@jp.panasonic.com" <yasutake.koichi@jp.panasonic.com>,
        "jonas@southpole.se" <jonas@southpole.se>,
        "jejb@parisc-linux.org" <jejb@parisc-linux.org>,
        "deller@gmx.de" <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        Liqin Chen <liqin.linux@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "cmetcalf@tilera.com" <cmetcalf@tilera.com>,
        "jdike@addtoit.com" <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        "gxt@mprc.pku.edu.cn" <gxt@mprc.pku.edu.cn>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chris@zankel.net" <chris@zankel.net>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "linux390@de.ibm.com" <linux390@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m32r@ml.linux-m32r.org" <linux-m32r@ml.linux-m32r.org>,
        "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
        "linux@lists.openrisc.net" <linux@lists.openrisc.net>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "user-mode-linux-devel@lists.sourceforge.net" 
        <user-mode-linux-devel@lists.sourceforge.net>,
        "user-mode-linux-user@lists.sourceforge.net" 
        <user-mode-linux-user@lists.sourceforge.net>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian explicitly
References: <53ECE9DD.80004@gmail.com> <C2D7FE5348E1B147BCA15975FBA230753C4BA528@IN01WEMBXA.internal.synopsys.com> <CAF0htA6qfhyVXEuLbruiz+dfxnieF-309NdxSDhoEYHM=aBhQA@mail.gmail.com> <53ED36AB.8020703@gmail.com> <C2D7FE5348E1B147BCA15975FBA230753C4BA673@IN01WEMBXA.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA230753C4BA673@IN01WEMBXA.internal.synopsys.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <gang.chen.5i5j@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gang.chen.5i5j@gmail.com
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



On 8/15/14 7:12, Vineet Gupta wrote:
> On Thursday 14 August 2014 03:22 PM, Chen Gang wrote:
>> For many individual modules may need check CPU_LITTLE_ENDIAN or
>> CPU_BIG_ENDIAN, which is an architecture's attribute.
>>
>> Or they have to list many architectures which they support, which they
>> don't support. And still, it is not precise.
>>
>> For architecture API, endian is a main architecture's attribute which
>> may be used by outside, so every architecture need let outside know
>> about it, explicitly.
> 
> I don't think that is correct. The modules need to use standard API e.g. swab
> which will take care of proper endian handling anyways. Why would a module do
> anything endian specific outside of those APIs.
> 

For building time, modules can check endians with various API. But for
config time, at present, we have no related standard API for it.

> And again is this churn just theoretical or do you really have a issue at hand ! I
> would not accept a change for ARC unless you prove that something is broken (or
> atleast potentially broken) !
> 

An issue for allmodconfig under microblaze, the original patch is below
(I guess, not only one module may match this case):


-------- Forwarded Message --------
Subject: [PATCH] drivers/isdn/hisax/Kconfig: Let HISAX_NETJET skip microblaze architecture
Date: Tue, 05 Aug 2014 02:24:09 +0800
From: Chen Gang <gang.chen.5i5j@gmail.com>
To: isdn@linux-pingi.de
CC: davem@davemloft.net, Jean Delvare <jdelvare@suse.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, monstr@monstr.eu

For HISAX_NETJET, HISAX_NETJET_U or related config needs !__BIG_ENDIAN,
so skip microblaze, just like skip all other architectures which have
no CONFIG_*_ENDIAN.

The related error (with allmodconfig under microblaze):

    CC [M]  drivers/isdn/hisax/nj_s.o
  drivers/isdn/hisax/nj_s.c: In function 'setup_netjet_s':
  drivers/isdn/hisax/nj_s.c:265:2: error: #error "not running on big endian machines now"
   #error "not running on big endian machines now"
    ^

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 drivers/isdn/hisax/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/isdn/hisax/Kconfig b/drivers/isdn/hisax/Kconfig
index 97465ac..eb83d94 100644
--- a/drivers/isdn/hisax/Kconfig
+++ b/drivers/isdn/hisax/Kconfig
@@ -237,7 +237,7 @@ config HISAX_MIC
 
 config HISAX_NETJET
 	bool "NETjet card"
-	depends on PCI && (BROKEN || !(PPC || PARISC || M68K || (MIPS && !CPU_LITTLE_ENDIAN) || FRV || (XTENSA && !CPU_LITTLE_ENDIAN)))
+	depends on PCI && (BROKEN || !(PPC || PARISC || M68K || (MIPS && !CPU_LITTLE_ENDIAN) || FRV || (XTENSA && !CPU_LITTLE_ENDIAN) || MICROBLAZE))
 	depends on VIRT_TO_BUS
 	help
 	  This enables HiSax support for the NetJet from Traverse
@@ -249,7 +249,7 @@ config HISAX_NETJET
 
 config HISAX_NETJET_U
 	bool "NETspider U card"
-	depends on PCI && (BROKEN || !(PPC || PARISC || M68K || (MIPS && !CPU_LITTLE_ENDIAN) || FRV || (XTENSA && !CPU_LITTLE_ENDIAN)))
+	depends on PCI && (BROKEN || !(PPC || PARISC || M68K || (MIPS && !CPU_LITTLE_ENDIAN) || FRV || (XTENSA && !CPU_LITTLE_ENDIAN) || MICROBLAZE))
 	depends on VIRT_TO_BUS
 	help
 	  This enables HiSax support for the Netspider U interface ISDN card





Thanks.
-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
