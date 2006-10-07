Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Oct 2006 23:10:25 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.181]:63376 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20039559AbWJGWKX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Oct 2006 23:10:23 +0100
Received: by py-out-1112.google.com with SMTP id i49so1395863pyi
        for <linux-mips@linux-mips.org>; Sat, 07 Oct 2006 15:10:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=T+teVh8eWdSnOMWJ81xUdYR2aVBuXK3cLo3r3U6IbDTx9pmeZs9CMgP9Eeon6qxzYgH89cHQWWzZaLLRB+92KFNjPZVmmmxppGBUxm5mHCg1c0eyTjz3wug6turXpMBVGOnRU6Owh5NT85vum+6EHdla23yKlLAZUJn7FyLm22I=
Received: by 10.35.10.17 with SMTP id n17mr9056408pyi;
        Sat, 07 Oct 2006 15:10:22 -0700 (PDT)
Received: from ?192.168.1.3? ( [61.125.212.22])
        by mx.google.com with ESMTP id q71sm1563852pyg.2006.10.07.15.10.20;
        Sat, 07 Oct 2006 15:10:21 -0700 (PDT)
In-Reply-To: <20061007105338.GA571@linux-mips.org>
References: <66910A579C9312469A7DF9ADB54A8B7D3E7324@exchange.ZeugmaSystems.local> <20061007021523.38254.qmail@web31512.mail.mud.yahoo.com> <20061007105338.GA571@linux-mips.org>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9D189830-9D85-4360-BEEE-72A3D5510D77@gmail.com>
Cc:	Jonathan Day <imipak@yahoo.com>,
	Kaz Kylheku <kaz@zeugmasystems.com>, linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	girish <girishvg@gmail.com>
Subject: Re: CFE problem: starting secondary CPU.
Date:	Sun, 8 Oct 2006 07:10:40 +0900
To:	Ralf Baechle <ralf@linux-mips.org>
X-Mailer: Apple Mail (2.749)
Return-Path: <girishvg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: girishvg@gmail.com
Precedence: bulk
X-list: linux-mips


On Oct 7, 2006, at 7:53 PM, Ralf Baechle wrote:

> On Fri, Oct 06, 2006 at 07:15:23PM -0700, Jonathan Day wrote:
>
>> I've seen the case where the second CPU did not start
>> on a Broadcom 1250 running a 64-bit kernel, but I
>> don't know if anyone has a good solution. I just
>> rigged the values in the Linux kernel so that it knows
>> about the second CPU. It's a godawful hack, but I
>> needed something quick at the time.
>>
>> Personally, I am not a fan of CFE and would love to
>> know if there's a better way to bootstrap.
>
> Firmware is a stepchild and all implementations have in common that  
> they're
> hated by they're users.  And my grief is there are way to many  
> different
> firmwares for MIPS systems.
>
>   Ralf
>

would it be reasonable to choose couple of bootmonitors and support  
them under MIPS/Linux umbrella. even bootable linux would be a good  
choice.
