Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 15:23:15 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:19501 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039612AbWJPOXJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Oct 2006 15:23:09 +0100
Received: by nf-out-0910.google.com with SMTP id l23so2501728nfc
        for <linux-mips@linux-mips.org>; Mon, 16 Oct 2006 07:23:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=k5rmL/VoJJ8TzxX6Vx8egjxon60c5i4flCtUgaHI8sEkNpjO/v/lSKiTRTYorzKPzRFKMhLrfWQzWBZlgwnqd9DE04/JiRU0AeCVPCADbniHgxHjNIBFcu37RDv3dWPgRgBsCAd2yjwbvFz7y9gjVzzzLzn4xlGShEHcdcpO3xQ=
Received: by 10.48.14.4 with SMTP id 4mr12253347nfn;
        Mon, 16 Oct 2006 07:23:05 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id x27sm893035nfb.2006.10.16.07.23.05;
        Mon, 16 Oct 2006 07:23:05 -0700 (PDT)
Message-ID: <453395CB.4040106@innova-card.com>
Date:	Mon, 16 Oct 2006 16:23:07 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
References: <11607431461469-git-send-email-fbuihuu@gmail.com> <1160743146503-git-send-email-fbuihuu@gmail.com> <45333CC1.3090704@innova-card.com> <20061016090923.GB25607@networkno.de>
In-Reply-To: <20061016090923.GB25607@networkno.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Franck Bui-Huu wrote:
>> Atsushi,
>>
>> Franck Bui-Huu wrote:
>>> Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
>>> ---
>> [snip]
>>> @@ -176,24 +174,34 @@ static unsigned long __init init_initrd(
>> [snip]
>>>  	end = (unsigned long)&_end;
>>>  	tmp = PAGE_ALIGN(end) - sizeof(u32) * 2;
>>>  	if (tmp < end)
>>>  		tmp += PAGE_SIZE;
>>>  
>> Any idea on what is this code for ?
>> It seems that a minimum gap is needed betweend the end of kernel
>> code and initrd but I don't see why...
> 
> AFAIR the bootmem map is placed there.
> 

boot_mem_map[] seems to be located in bss.

		Franck
