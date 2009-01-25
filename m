Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2009 10:18:31 +0000 (GMT)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:14084 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S21365077AbZAYKS3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Jan 2009 10:18:29 +0000
Received: from [192.168.236.58] ([217.109.65.213])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id EAA19667;
	Sun, 25 Jan 2009 04:50:55 -0600
Message-ID: <497C3C6F.3000209@paralogos.com>
Date:	Sun, 25 Jan 2009 04:18:23 -0600
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
CC:	linux-mips@linux-mips.org,
	"Dezhong Diao (dediao)" <dediao@cisco.com>,
	"Victor Williams Jr (williavi)" <williavi@cisco.com>,
	"Michael Sundius -X (msundius - Yoh Services LLC at Cisco)" 
	<msundius@cisco.com>
Subject: Re: 2.6.28 will not boot on 24K processor, ebase incorrectly modified
 in set_uncached_handler
References: <FF038EB85946AA46B18DFEE6E6F8A28976825D@xmb-rtp-218.amer.cisco.com>
In-Reply-To: <FF038EB85946AA46B18DFEE6E6F8A28976825D@xmb-rtp-218.amer.cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

David VomLehn (dvomlehn) wrote:
> The 2.6.28 kernel dies in memcpy when called from set_vi_srs_handler on
> a
> 24K processor. The problem is that ebase has an invalid value. The
> original
> value of ebase comes from a bootmem allocation, but the following code
> in
> set_uncached_handler takes a perfectly good kseg0 address and turns it
> into
> an invalid kseg1 address.
>
> 	if (cpu_has_mips_r2)
> 		ebase += (read_c0_ebase() & 0x3ffff000);
>
> This code was added in commit 566f74f6b2f8b85d5b8d6caaf97e5672cecd3e3e.
>   
I remember worrying about why it was "+=" and not "=" when others had 
problems with that patch. See the thread "NXP STB225 board support" from 
January 8 or so.  When I asked about that, I got a comment that the add 
operation was correct, but that patch *should* have said "uncached_ebase 
+= (read_c0_ebase() & 0x3ffff000);"  I guess uncache_ebase is assumed to 
contain something interesting in some non-address bits. Try pre-pending 
"uncached_" to that "ebase"...

          Regards,

          Kevin K.
