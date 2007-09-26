Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 10:56:23 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.189]:46086 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20029454AbXIZJ4P (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 10:56:15 +0100
Received: by mu-out-0910.google.com with SMTP id w1so2634371mue
        for <linux-mips@linux-mips.org>; Wed, 26 Sep 2007 02:55:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=sVdFf77ODkHC44NA7Ty3NbkgEcRfgFu3zfYo8AkGD9Y=;
        b=jR4T/9d5FcAE5lKd6I4XHTJbrhuStvQFNHBMEcpiFzSuiz1xm26dVkXH8bwDsYUSFPzVcNKkVdmNBPMFYZwsZD2PUOTzboVdZtOaI3QRNPiwRh0FBuU++i0QytcMgD55hqk//vnz5Y5qIkerP7kSHmyUsMcyAYB4+2oI/ynUSb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ue/DqQ17JLvfaIGZWyWhIy3swDKgq+qwvNOuQI3bUB/98SDXt8mrEiRnuNlohn6iKFQRW3F8XPcpS90TDH9jozM3SDAV/SSyNr3ViCLJe+0Y5grpoTCuUbucM/5nR9yZvfdzVYPaLmgn2lpCsqV4ipl/nDQNJNOaMGi+t2CYImw=
Received: by 10.82.154.12 with SMTP id b12mr981980bue.1190800556688;
        Wed, 26 Sep 2007 02:55:56 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id f31sm1222957fkf.2007.09.26.02.55.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Sep 2007 02:55:53 -0700 (PDT)
Message-ID: <46FA2C39.9020503@gmail.com>
Date:	Wed, 26 Sep 2007 11:54:01 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Martin Michlmayr <tbm@cyrius.com>
CC:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
References: <20070925181353.GA15412@deprecation.cyrius.com> <46FA1260.4000404@gmail.com> <20070926091443.GA10236@deprecation.cyrius.com>
In-Reply-To: <20070926091443.GA10236@deprecation.cyrius.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> * Franck Bui-Huu <vagabon.xyz@gmail.com> [2007-09-26 10:03]:
>> To verify this, could you apply the following patch _without_ Ralf's
>> commit and report back the trace. You may need to enable early printk
>> to see something and be sure CONFIG_KALLSYMS_ALL is set.
> 
> 5152902+253674 entry: 0x804ac000
> Linux version 2.6.22-2-r5k-ip32 (2.6.22-5) (tbm@em64t) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #3 Wed Sep 26 09:10:31 UTC 2007
> ARCH: SGI-IP32
> PROMLIB: ARC firmware Version 1 Revision 10
> CRIME id a rev 1 at 0x0000000014000000
> CRIME MC: bank 0 base 0x0000000000000000 size 128MiB
> CRIME MC: bank 1 base 0x0000000008000000 size 128MiB
> CRIME MC: bank 2 base 0x0000000050000000 size 32MiB
> CRIME MC: bank 3 base 0x0000000052000000 size 32MiB
> CPU revision is: 00002321
> FPU revision is: 00002310
> Determined physical RAM map:
>  memory: 0000000010000000 @ 0000000000000000 (usable)
>  memory: 0000000004000000 @ 0000000050000000 (usable)
> *** __pa: symbol in CKSEG0 found: wireless_nlevent_queue+0x20/0x20
> 

hmm it doesn't really help here. Could you print out the address value
instead ?

> Exception: <vector=Normal>
> Status register: 0x34010082<CU1,CU0,FR,DE,IPL=8,KX,MODE=KERNEL>
> Cause register: 0x8024<CE=0,IP8,EXC=BREAK>
> Exception PC: 0x804bbc2c, Exception RA: 0x804bbc2c
> Breakpoint exception at address 0xbffffff7
>   Saved user regs in hex (&gpda 0x810617b8, &_regs 0x810619b8):
>   arg: 81070000 2f1 0 1
>   tmp: 81070000 8052bf70 a13fb518 81077d40 8052bf70 a13fba0c 810723b0 81054090
>   sve: 81070000 4015fa0c 0 4618fbd8 0 4047cfc7 0 3ebf5e51
>   t8 81070000 t9 0 at 0 v0 402003f7 v1 0 k1 46
>   gp 81070000 fp 0 sp 0 ra 0
> 

Weird, all these symbols seem to be 32 bits ones...

Could you put somewhere your vmlinux you're actually running ?

thanks,

		Franck
