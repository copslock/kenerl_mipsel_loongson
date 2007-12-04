Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Dec 2007 02:22:57 +0000 (GMT)
Received: from wa-out-1112.google.com ([209.85.146.180]:63517 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20030690AbXLDCWt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Dec 2007 02:22:49 +0000
Received: by wa-out-1112.google.com with SMTP id m16so5567078waf
        for <linux-mips@linux-mips.org>; Mon, 03 Dec 2007 18:22:36 -0800 (PST)
Received: by 10.142.72.21 with SMTP id u21mr10479wfa.1196734956458;
        Mon, 03 Dec 2007 18:22:36 -0800 (PST)
Received: by 10.142.169.11 with HTTP; Mon, 3 Dec 2007 18:22:35 -0800 (PST)
Message-ID: <fb2fec70712031822q36b1834fq99a96406390409b8@mail.gmail.com>
Date:	Tue, 4 Dec 2007 10:22:35 +0800
From:	"David Kuk" <david.kuk@entone.com>
To:	"YH Lin" <YH_Lin@sdesigns.com>
Subject: Re: smp8634 add memory at dram1
Cc:	linux-mips@linux-mips.org
In-Reply-To: <5DF100B598199744B111FCEA5222E78A01CB9F5F@sigma-exch1.sdesigns.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14758_19589160.1196734956430"
References: <5DF100B598199744B111FCEA5222E78A01CB9F5F@sigma-exch1.sdesigns.com>
Return-Path: <david.kuk@entone.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.kuk@entone.com
Precedence: bulk
X-list: linux-mips

------=_Part_14758_19589160.1196734956430
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear YH

I am sorry i have been disturbed by other issues, the memory problem seems
little bit difficult to me. In our case, i saw that in prom.c under
mips/tango2, the function prom_init , it shows that :
memcfg_t *m=(memcfg_t*)KSEG1ADDR(MEM_BASE_dram_controller_0+FM_MEMCFG);

it's seems the kernel has hard coded to point the starting memory to DRAM
controller 0's starting address, if now, i have remap 64mb memory at DRAM
controller 1 at remap register 4, The problem is come, the kernel will
ignore any memory before dram controller 0's starting address. Even i have
add 0x0c000000--0x10000000 as boot memory, it still think it's first usable
pfn is at 0x10000000.

my solution is 3 steps

1, modify the compiler, let the linux start address moved to 0x0c000000,
2. modify the YAMON, and map the DRAM 1 controller to remap register4 in
YAMON stage
3, modify the linux, to set the two piece of memory to the kernel as boot
memory .

it's this possible, or it have other better solution ?

thx a lot for your kindly help !


best wishes
David

------=_Part_14758_19589160.1196734956430
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear YH<br><br>I am sorry i have been disturbed by other issues, the memory problem seems little bit difficult to me. In our case, i saw that in prom.c under mips/tango2, the function prom_init , it shows that :<br>memcfg_t *m=(memcfg_t*)KSEG1ADDR(MEM_BASE_dram_controller_0+FM_MEMCFG);
<br><br>it&#39;s seems the kernel has hard coded to point the starting memory to DRAM controller 0&#39;s starting address, if now, i have remap 64mb memory at DRAM controller 1 at remap register 4, The problem is come, the kernel will ignore any memory before dram controller 0&#39;s starting address. Even i have add 0x0c000000--0x10000000 as boot memory, it still think it&#39;s first usable pfn is at 0x10000000.
<br><br>my solution is 3 steps<br><br>1, modify the compiler, let the linux start address moved to 0x0c000000, <br>2. modify the YAMON, and map the DRAM 1 controller to remap register4 in YAMON stage<br>3, modify the linux, to set the two piece of memory to the kernel as boot memory .
<br><br>it&#39;s this possible, or it have other better solution ?<br><br>thx a lot for your kindly help !<br><br><br>best wishes<br>David<br><br><br>

------=_Part_14758_19589160.1196734956430--
