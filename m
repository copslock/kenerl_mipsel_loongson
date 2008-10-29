Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 07:38:27 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.153]:64211 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S22632640AbYJ2HiU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2008 07:38:20 +0000
Received: by fg-out-1718.google.com with SMTP id d23so2641249fga.32
        for <linux-mips@linux-mips.org>; Wed, 29 Oct 2008 00:38:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=7wH9VwzxdHDuwBOA2sclJh5R+Bn59EpeTeL7CDqQZQg=;
        b=LQHSR23gPpMBBLx3wE7kZ1JrpjkIcyIeT7SFDTINkfHduSGx7Cj8mPdH8JKHJ6Lero
         fQTV40tKyKD0tmosEJhD87qcnRU5uoWCCbR05XU3iaIgfYtMoavyQIDTtI/8oiohq6mC
         7Ee/UmEdnRtR/4RFXJjYPqBhrXYt4ZLhiUDQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=GkVRwHuAnX1cSnfMcJfYhFOc35oOeTs46hUQbrD2Xa+ygvqCnrFj9yssl5oWqYebI2
         x+Vyxtgy4sxvAQRepRv52k+MLjoi4hupDoWUbx91oyORu0MoT/cYPzPWuz2K72X567Xk
         bFGwuzZX2TASKgoTsmaFxUc6/V8LKuPr32U3E=
Received: by 10.86.61.13 with SMTP id j13mr5378276fga.71.1225265895844;
        Wed, 29 Oct 2008 00:38:15 -0700 (PDT)
Received: from innova-card.com (1-61.252-81.static-ip.oleane.fr [81.252.61.1])
        by mx.google.com with ESMTPS id l12sm3782547fgb.6.2008.10.29.00.38.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Oct 2008 00:38:13 -0700 (PDT)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	Chad Reese <kreese@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 11/36] MIPSR2 ebase isn't just CAC_BASE
Date:	Wed, 29 Oct 2008 08:38:01 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
References: <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <alpine.LFD.1.10.0810281604250.27396@ftp.linux-mips.org> <49073A38.3070808@caviumnetworks.com>
In-Reply-To: <49073A38.3070808@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200810290838.01691.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Tuesday 28 October 2008 17:13:44 Chad Reese wrote:
> Maciej W. Rozycki wrote:
> > On Tue, 28 Oct 2008, Ralf Baechle wrote:
> >> Another thing I noticed is that we don't use write_c0_ebase(), so the
> >> firmware better setup this correctly or we crash and burn.  We better
> >> should initialize that right ...
> > 
> >  Well, your version still does not do it...
> 
> From an Octeon perspective, we'd prefer that the kernel not touch ebase
> as we set it in the bootloader. The bootloader sets the proper value
> based on the number of kernels being loaded and which cores the kernel
> is loaded on. This allows some interesting things, like running 16
> kernels each on a different CPU. Although 16 kernels is just a toy
> project, we have a number of customers that run two kernels. They choose
> which cores the kernels run on dynamically at boot time.

 Our system (4KSd-based) also has the bootloader setting EBASE,
 so like Chad, I'd prefer it if the kernel doesn't (always?) do
 it, please.  (We're not doing anything tricky like what Chad
 mentions, it's just that on the SoC in question, it's perhaps
 the easiest way of handling the situation.)

cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
