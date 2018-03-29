Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2018 19:43:42 +0200 (CEST)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:54070
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeC2Rne7G1qa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2018 19:43:34 +0200
Received: by mail-it0-x241.google.com with SMTP id m134-v6so9143373itb.3
        for <linux-mips@linux-mips.org>; Thu, 29 Mar 2018 10:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=XYm81nFVNoG1ewXl1m2LzOEska8lq95mNWr4Z6VDGjw=;
        b=y+2eclM0AHRnnlmmpWVA5ToVQmte8qRM89ggtql9WZKCHqnqaKFqqMLFzMkGrUYgRT
         8S0SqkqTcA+p/xztDo3y2kIE5oB7ne3+gRDULOkian9o6j/db2k9dInBXcbjxIit1Twc
         jxugdJVzyTUdv85ZTQaQvatnW66dHmkLaWQvMFplclRY1e8UgXMjgfIPvbC8JYJgQZEE
         v2QNbCdTd5lQSH/kQtXcGWyMty/0YNV3EKdxjWPe5idO0TTUbJLqkLgUdHmu/RC77VXO
         EPmWs1TmSOpVzWlOIOXzUDdssJorjEZkR9/bKuHZ33s/x6R850ADd3/SgEzwLF8vfdCh
         Aliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=XYm81nFVNoG1ewXl1m2LzOEska8lq95mNWr4Z6VDGjw=;
        b=h9NJDsiFe6+xSsGq6KHGF02awVKXQSzAHa8efLZTOl36bDemkrYZNVyXo8xNp05D5T
         Mq03oERanQ4gxWBUSKNJbZpN+7qnPI6IyypPl56qR3raSCHklE3+5J/oF9l51hiQbLkF
         7JohG/8sVs33JklbX0H9L079fgkUKy6HEtEyh7X6VQdZw3VW89oWOHfLFauC5OSKJ4Pd
         Fqhi22VcSY7tBZt1c9XtpcFmj6z2ubAnDvavn4fqOodpOusv6jZgs0Gwa8k/2x9gGLYm
         QcQzt2NIAMQblh+uKUP+hsLBnEWB66oDyZyB6esKL7Ud4Ua1ql8fd3z5qdN87Iv7A2Vj
         R/LA==
X-Gm-Message-State: AElRT7ELIuxrTLB+mmVQ6J1vFT88i1ksvhSmqDcS4mDwz2FbSKaUMDSU
        hg9/dVvM/MUSMgI2bxFOjANW+A==
X-Google-Smtp-Source: AIpwx4/D5SaqcquKgLTJ8OpYd7ecPwYJ1tFPpBRY8cAZncQQJ2qAvCNG1dYv0b2H4YTTwO11OMmunA==
X-Received: by 2002:a24:ddd0:: with SMTP id t199-v6mr8264852itf.122.1522345407473;
        Thu, 29 Mar 2018 10:43:27 -0700 (PDT)
Received: from [192.168.42.90] ([172.58.143.62])
        by smtp.googlemail.com with ESMTPSA id e71sm4144545iof.28.2018.03.29.10.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Mar 2018 10:43:26 -0700 (PDT)
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Oliver <oohall@gmail.com>
Cc:     Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <jhogan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Balbir Singh <bsingharora@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joe Perches <joe@perches.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org, Nicholas Piggin <npiggin@gmail.com>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
 <20180328221401.GA14084@n2100.armlinux.org.uk>
 <CAOSf1CG8gQjoL5rDMRMcZp=D8jBEQ9JBSG68=CiXnitC+4Kjvg@mail.gmail.com>
 <20180329152749.GC16141@n2100.armlinux.org.uk>
From:   Rob Landley <rob@landley.net>
Message-ID: <1ec5d19a-d649-38bd-ab89-868e1ad9dd7f@landley.net>
Date:   Thu, 29 Mar 2018 12:43:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329152749.GC16141@n2100.armlinux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------292EE39B94C5DBED4CD25C9B"
Content-Language: en-US
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
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

This is a multi-part message in MIME format.
--------------292EE39B94C5DBED4CD25C9B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 03/29/2018 10:27 AM, Russell King - ARM Linux wrote:
> On Thu, Mar 29, 2018 at 09:37:52AM +1100, Oliver wrote:
>> On Thu, Mar 29, 2018 at 9:14 AM, Russell King - ARM Linux
>>> LD_DEAD_CODE_DATA_ELIMINATION is a symbol without a prompt, and from
>>> what I can see, nothing selects it.  Therefore, the symbol is always
>>> disabled, and so the feature never gets used in mainline kernels.
>>>
>>> Brings up the obvious question - why is it there if it's completely
>>> unused?  (Maybe to cause confusion, and allowing a justification
>>> for __weak ?)
>>
>> IIRC Nick had some patches to do the arch enablement for powerpc, but
>> I'm not sure what happened to them though. I suspect it just fell down
>> Nick's ever growing TODO list.
> 
> I've given it a go on ARM, marking every linker-built table with KEEP()
> and comparing the System.map files.  The resulting kernel is around
> 150k smaller, which seems good.
> 
> However, it doesn't boot - and I don't know why.  Booting the kernel
> under kvmtool in a VM using virtio-console, I can find no way to get
> any kernel messages out of it.  Using lkvm debug, I can see that the
> PC is stuck inside die(), and that's the only information I have.

qemu-system-arm's "-s" option lets you hook to the hardware with gdb, as if
using one of those jtags that speaks gdbserver protocol. It stops waiting for
you to attach with 'target remote' it, then 'file vmlinux' to load the symbols...

The miniconfig and qemu invocation I use for arm64 are attached, tested with
2.11.0 on a 4.14 kernel. You should be able to just "qemu-aarch64.sh -s" and
then probably "target remote 127.0.0.1:1234"? (Been a while since I've used it,
don't have a cross-gdb for arm64 lying around...)

Sigh, I just tried -s and qemu 2.11.0 is _not_ waiting for gdb to attach on
arm64, despite what the docs say:

$ qemu-system-aarch64 --help | grep gdb
-gdb dev        wait for gdb connection on 'dev'
-s              shorthand for -gdb tcp::1234

Another random regression in qemu, gee what a surprise.

> It dies before bringing up the other CPUs, so it's a very early death.
> 
> I don't think other console types are available under ARM64.

I've often found useful the two line version of:

https://balau82.wordpress.com/2010/02/28/hello-world-for-bare-metal-arm-using-qemu/

Which is generally some variant of:

{char *XX = "blah"; while (*XX) {while (*SERIAL_STATUS_REGISTER & OUT_READY);
*SERIAL_OUT = *XX++;}}

(I.E. balu cheated not spinning checking the ready-for-next-byte bit, because
qemu's always angry.)

That trick lets you cut and paste a print statement into all sorts of early
hardware nonsense, on most architectures. You just have to look up
SERIAL_STATUS_REGISTER, OUT_OK_BIT, and SERIAL_OUT values for the serial port du
jour.

That said I've mostly used it in things like u-boot. I dunno at what point the
kernel's done enough setup that direct banging on registers would stop working.
(Works in the decompresion code, anyway.) And it assumes the port's set to the
right speed (usually left there by the bootloader)...

Rob

--------------292EE39B94C5DBED4CD25C9B
Content-Type: text/plain; charset=UTF-8;
 name="aarch64.miniconf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="aarch64.miniconf"

IyBtYWtlIEFSQ0g9YXJtNjQgYWxsbm9jb25maWcgS0NPTkZJR19BTExDT05GSUc9YWFyY2g2
NC5taW5pY29uZgojIG1ha2UgQVJDSD1hcm02NCAtaiAkKG5wcm9jKQojIGJvb3QgYXJjaC9h
cm02NC9ib290L0ltYWdlCgoKQ09ORklHX01NVT15CkNPTkZJR19BUkNIX01VTFRJX1Y3PXkK
Q09ORklHX0FSQ0hfVklSVD15CkNPTkZJR19TT0NfRFJBN1hYPXkKQ09ORklHX0FSQ0hfT01B
UDJQTFVTX1RZUElDQUw9eQpDT05GSUdfQVJDSF9BTFBJTkU9eQpDT05GSUdfQVJNX1RIVU1C
PXkKQ09ORklHX1ZEU089eQpDT05GSUdfQ1BVX0lETEU9eQpDT05GSUdfQVJNX0NQVUlETEU9
eQpDT05GSUdfS0VSTkVMX01PREVfTkVPTj15CgpDT05GSUdfU0VSSUFMX0FNQkFfUEwwMTE9
eQpDT05GSUdfU0VSSUFMX0FNQkFfUEwwMTFfQ09OU09MRT15CgpDT05GSUdfUlRDX0NMQVNT
PXkKQ09ORklHX1JUQ19IQ1RPU1lTPXkKQ09ORklHX1JUQ19EUlZfUEwwMzE9eQoKQ09ORklH
X05FVF9DT1JFPXkKQ09ORklHX1ZJUlRJT19ORVQ9eQoKQ09ORklHX1BDST15CkNPTkZJR19Q
Q0lfSE9TVF9HRU5FUklDPXkKQ09ORklHX1ZJUlRJT19CTEs9eQpDT05GSUdfVklSVElPX1BD
ST15CkNPTkZJR19WSVJUSU9fTU1JTz15CgpDT05GSUdfQVRBPXkKQ09ORklHX0FUQV9TRkY9
eQpDT05GSUdfQVRBX0JNRE1BPXkKQ09ORklHX0FUQV9QSUlYPXkKCkNPTkZJR19QQVRBX1BM
QVRGT1JNPXkKQ09ORklHX1BBVEFfT0ZfUExBVEZPUk09eQpDT05GSUdfQVRBX0dFTkVSSUM9
eQoKCiMgQ09ORklHX0VNQkVEREVEIGlzIG5vdCBzZXQKQ09ORklHX0VBUkxZX1BSSU5USz15
CkNPTkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0JJTkZNVF9TQ1JJUFQ9eQpDT05GSUdfTk9f
SFo9eQpDT05GSUdfSElHSF9SRVNfVElNRVJTPXkKCkNPTkZJR19CTEtfREVWPXkKQ09ORklH
X0JMS19ERVZfSU5JVFJEPXkKQ09ORklHX1JEX0daSVA9eQoKQ09ORklHX0JMS19ERVZfTE9P
UD15CkNPTkZJR19FWFQ0X0ZTPXkKQ09ORklHX0VYVDRfVVNFX0ZPUl9FWFQyPXkKQ09ORklH
X1ZGQVRfRlM9eQpDT05GSUdfRkFUX0RFRkFVTFRfVVRGOD15CkNPTkZJR19NSVNDX0ZJTEVT
WVNURU1TPXkKQ09ORklHX1NRVUFTSEZTPXkKQ09ORklHX1NRVUFTSEZTX1hBVFRSPXkKQ09O
RklHX1NRVUFTSEZTX1pMSUI9eQpDT05GSUdfREVWVE1QRlM9eQpDT05GSUdfREVWVE1QRlNf
TU9VTlQ9eQpDT05GSUdfVE1QRlM9eQpDT05GSUdfVE1QRlNfUE9TSVhfQUNMPXkKCkNPTkZJ
R19ORVQ9eQpDT05GSUdfUEFDS0VUPXkKQ09ORklHX1VOSVg9eQpDT05GSUdfSU5FVD15CkNP
TkZJR19JUFY2PXkKQ09ORklHX05FVERFVklDRVM9eQojQ09ORklHX05FVF9DT1JFPXkKI0NP
TkZJR19ORVRDT05TT0xFPXkKQ09ORklHX0VUSEVSTkVUPXkKCg==
--------------292EE39B94C5DBED4CD25C9B
Content-Type: application/x-shellscript;
 name="qemu-aarch64.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="qemu-aarch64.sh"

cWVtdS1zeXN0ZW0tYWFyY2g2NCAtcyAtTSB2aXJ0IC1jcHUgY29ydGV4LWE1NyAtbm9ncmFw
aGljIC1uby1yZWJvb3QgLW0gMjU2IC1hcHBlbmQgInBhbmljPTEgSE9TVD1hYXJjaDY0IGNv
bnNvbGU9dHR5QU1BMCIgLWtlcm5lbCBJbWFnZSAtaW5pdHJkIGFhcmNoNjQtbGludXgtbXVz
bGVhYmktcm9vdC5jcGlvLmd6ICIkQCIK
--------------292EE39B94C5DBED4CD25C9B--
