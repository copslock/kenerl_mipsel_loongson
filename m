Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2009 08:19:10 +0100 (BST)
Received: from ti-out-0910.google.com ([209.85.142.186]:62596 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20024915AbZDTHTE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Apr 2009 08:19:04 +0100
Received: by ti-out-0910.google.com with SMTP id 11so1145948tim.20
        for <multiple recipients>; Mon, 20 Apr 2009 00:19:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=/OuYhdX/QymCKziN5J1y+qWtbKUbzlCYkoST6LrmN2o=;
        b=adss4PXW/cUBYu2MbpLKMrMKp3TLGDMy02jSQR/f1UlCTK+z49iNzetoPrEA6T0t6u
         fBHz2X9w2Smrl5IaJHvC45vO7NKnL3z7IaMJXkrv4l6vH8iQosbIxE0TFgGUyugiE1kO
         UP/+9oVO0MwGBBbXva7yjRzAUP8CJLg+rgHjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=hEeoNltDuyOZb8GYEtd1Ya5Dii1F1Nq9vk0MBMvsu8AggTvB6W2mW6H/ikvkkLEQ5K
         4L8XUmP6k60W8crtGkESLLl/LlN+1YBA8jWYiA/06NBV6Oh/6xSj4ggIDsriR3s2IzsH
         TtHf81LjPCxbgvtBLGMny+hqJNcUTwEDJdjlY=
Received: by 10.110.11.4 with SMTP id 4mr6001394tik.14.1240211940357;
        Mon, 20 Apr 2009 00:19:00 -0700 (PDT)
Received: from ?172.16.18.144? ([222.92.8.142])
        by mx.google.com with ESMTPS id y5sm69910tia.23.2009.04.20.00.18.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 00:18:59 -0700 (PDT)
Subject: Re: "RT_PREEMPT for loongson" is updated to patch-2.6.29.1-rt8
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Zhang Le <r0bertz@gentoo.org>
Cc:	linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@hofr.at>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, zhangfx@lemote.com,
	loongson-dev@googlegroups.com, yanh@lemote.com,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-rt-users@vger.kernel.org
In-Reply-To: <20090420050419.GA22520@adriano.hkcable.com.hk>
References: <1240193547.25532.52.camel@falcon>
	 <20090420050419.GA22520@adriano.hkcable.com.hk>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Mon, 20 Apr 2009 15:18:46 +0800
Message-Id: <1240211926.8884.27.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-04-20 at 13:04 +0800, Zhang Le wrote:
> Hi, Zhangjin,
> 
> Ralf told me he has a ftrace implementation too.
> 
> 11:47 < Ralf> r0bertz: ftrace looks nice but not yet mergable yet.
> 11:47 < Ralf> r0bertz: I also have my own ftrace implementation which in some
> parts is better, in some is worse. 
> 11:47 < Ralf> r0bertz: So this is going to be quite a job.  
> 
> So I think you can talk to Ralf about how to get this merged, :)
> 

to Zhangle, 

thx very much for your info :-) 

hope Ralf can reply this E-mail and pull the source code from my git
tree:

git://dev.lemote.com/rt4ls.git

to Ralf, 

I have divided ftrace to several commits in the above git tree, hope you
can check it, thx :-) 

in addition to the static/dynamic/graph function tracer & system call
tracer implementation, a mips specific ring_buffer_time_stamp
(kernel/trace/ring_buffer.c) is also implemented to get 1us precision
time, this is very important to make ftrace available in mips,
otherwise, we can only get 1ms precision time for the original
ring_buffer_time_stamp is based on sched_clock(jiffies based). 

perhaps we can implement a more precise sched_clock directly, just as
x86 does(native_sched_clock, tsc based), but in mips, there is only a
32bit timer count which will quickly overflow, so it will need an extra
overflow protection, which may influence the other parts of the kernel.

best regards,
Wu Zhangjin
