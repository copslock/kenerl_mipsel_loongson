Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2009 11:10:01 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.149]:17305 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492470AbZH1JJz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Aug 2009 11:09:55 +0200
Received: by ey-out-1920.google.com with SMTP id 13so356562eye.52
        for <linux-mips@linux-mips.org>; Fri, 28 Aug 2009 02:09:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KP4OEAgTQWvytMk40XIbQTV4VzrLCg+xhR3dTCrR+d8=;
        b=iWs7Yu+h8OW0l0Klzbd/suWND315WmfknLUwiYsNtPjnqbCCU9OyjjM5sQc8x7MRH1
         f2b/J/uOMgyO9BkK7KEcJVbX876SFFxtrlEq3iuWJCCvnzsi1YB+uD/gaPIl3A9xvWn+
         FWEoAGxVODC7Kp+iASgz9ODk5KCwSO9b/SXq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=t+LITZXEm59kY+5B+C494i4nVMpXeh0nZZ8QkIKl+5/q1u4FuPkSfipE9f6KBHdmrA
         fjUrafpdsfjZFmsvg+ysiwZjONvzBs94SzSuc3lY9JQKpCL1SX/ZGjY3UFheUnPk1lzE
         GgxXil80hchhIthjVEmePaet0H7YCGGWlc0NU=
Received: by 10.211.200.7 with SMTP id c7mr10904621ebq.54.1251450594534;
        Fri, 28 Aug 2009 02:09:54 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 10sm1373522eyd.37.2009.08.28.02.09.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 02:09:53 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	"wilbur.chan" <wilbur512@gmail.com>
Subject: Re: kexec on mips failed
Date:	Fri, 28 Aug 2009 11:09:51 +0200
User-Agent: KMail/1.9.9
Cc:	nschichan@freebox.fr, linux-mips@linux-mips.org
References: <e997b7420908160920y14d8ea95v5fb25eba67e7b6db@mail.gmail.com>
In-Reply-To: <e997b7420908160920y14d8ea95v5fb25eba67e7b6db@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908281109.52499.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi,

Le Sunday 16 August 2009 18:20:56 wilbur.chan, vous avez écrit :
> Hi,Nicolas,
>
>
> I've got some problem with kexec on mips32...
>
>
> in your code for kexec on mips32, there is a relocate_new_kernel function .
>
>
> In the end of this function , it jump to kexec_start_address by   'j  s1'
>
>
>
> Because I  changed the kexec-tools code  ,in the hope that, it
> simplely passed the new kernel segment  data  into the old kernel.(so
>
> I didn't  pass  the command-line segment in, in my code, there is just
> one segment , segment[0] = kernel_data).
>
>
> So  I need to change register s1 to the new kernel entry address, and
> jump to new kernel directly.
>
>
>
> In my vmlinux,  the entry is 0x802b0000，so I let image->start =
> 0x2b0000，and invoke relocate_new_kernel.
>
>
> However, whether I changed kexec_start_address to 0x802b0000 or
> 0x2b0000 , the  'j  s1'  seemed taking no effect?

Should not you add a nop right after the j s1 in order to fill in the branch 
delay slot with an instruction which does nothing ?

>
>
> (I wrote 88 to address0xa1230000  before 'j  s1' , it succedd .I also
> wrote 78 to address 0xa1230000 in the beginning
>
> of head.S of the new kernel , but failed. And I reset the board to
> uboot mode, used 'md 0x802b0400' to display the new kernel
>
> in ram, it is identical  to the objdump content of the vmlinux.  So I
> guess, this problem lays in the failing of 'j  0x802b0000'
>
> or 'j   0x2b0000'.    I don't know why 'j s1' failed , any suggestions
> about this ?  Thank you very much.
>
> regads,
>
> Wilbur



-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
