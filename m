Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2007 10:51:13 +0000 (GMT)
Received: from wx-out-0506.google.com ([66.249.82.239]:1930 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037410AbXBVKvJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Feb 2007 10:51:09 +0000
Received: by wx-out-0506.google.com with SMTP id t14so133240wxc
        for <linux-mips@linux-mips.org>; Thu, 22 Feb 2007 02:50:08 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SOYFDvIzImzBwm3aeITlLyP6iAwF7KIWjs/H7y0h5pjB+QHBSty8Xqlz/7xEJZPZHZ5sBrNQySdqSD8vOglIJ74c60609pYGV99dAAv3U6I2Hrc4qFYzwBdo74zlSs7MpRNtd7azBqi24RzddXAdXPWp7ORyiR6Iv1v6HccmRXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=macS0Nlc60dNTRC0XdTnmKrtnHTEospBkLJDlfruopceZUXUy+zEszhlLkap5nrwUiNgrCuqXG86sPBw0hwWxcLJ89ftrIpBUAk1jpjEwqDlq4o5HpjxuZ7289LKYgGFtRXs2iOCDKhMCAH5eZk/pKEJtfIYRYKuDB+7CMVV1qE=
Received: by 10.90.118.8 with SMTP id q8mr163930agc.1172141408161;
        Thu, 22 Feb 2007 02:50:08 -0800 (PST)
Received: by 10.90.51.4 with HTTP; Thu, 22 Feb 2007 02:50:08 -0800 (PST)
Message-ID: <f68850780702220250x57f4f678re104caecfeec6ef2@mail.gmail.com>
Date:	Thu, 22 Feb 2007 16:20:08 +0530
From:	"Raseel Bhagat" <raseelbhagat@gmail.com>
To:	kernelnewbies <kernelnewbies@nl.linux.org>,
	newbie <linux-newbie@vger.kernel.org>, linux-mips@linux-mips.org
Subject: Re: not getting command prompt at the console
In-Reply-To: <20070222102540.GB31252@gateway.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b115cb5f0702220149wfbfc051qc8d0106b9e4ed98d@mail.gmail.com>
	 <20070222102540.GB31252@gateway.home>
Return-Path: <raseelbhagat@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raseelbhagat@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Rajat,

On 2/22/07, Erik Mouw <mouw@nl.linux.org> wrote:
> On Thu, Feb 22, 2007 at 03:19:10PM +0530, Rajat Jain wrote:
> > Next, I expected to see a command prompt which never comes. At this
> > point if I debug, I find the processor executing the idle process.
> >
> > I am successfully hable to telnet to the board and fire whatever
> > commands I want though. How do I bring the prompt to the serial
> > console?
>
> Run a getty on the serial device (I suppose you're using a serial
> port).
> Could be that the serial driver changed or that you forgot to compile a
> driver for the serial device.
>

Also , assuming you are using a serial console , check your entries in
the inittab file .
It should look  something like :
ttyS0::respawn:/sbin/getty ttyS0 115200 linux
