Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2005 08:00:52 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.195]:34320 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133513AbVJEHAg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Oct 2005 08:00:36 +0100
Received: by zproxy.gmail.com with SMTP id j2so54729nzf
        for <linux-mips@linux-mips.org>; Wed, 05 Oct 2005 00:00:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QMpT7+4jXabXDYaB8mUzIMiuCUHFy1Jvc/yQQN4eJiTFqInwxBm8ngZyX+fVTj3qqtnjZYGTA3vFL/o/uSZRh+dMSnychnOh6bJXq+2mX/xYzczYSDRTQOC1pFkHaTirGpCZ7mRa2kSIsxleymChLJ1hotWRTio1+OqoDYwzNzQ=
Received: by 10.36.43.8 with SMTP id q8mr214417nzq;
        Wed, 05 Oct 2005 00:00:30 -0700 (PDT)
Received: by 10.36.49.3 with HTTP; Wed, 5 Oct 2005 00:00:30 -0700 (PDT)
Message-ID: <cda58cb80510050000r1baea5c7k@mail.gmail.com>
Date:	Wed, 5 Oct 2005 09:00:30 +0200
From:	Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: [PATCH] Add support for 4KS cpu.
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <434277D5.1090603@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80510040149p690397afo@mail.gmail.com>
	 <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl>
	 <434277D5.1090603@mips.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2005/10/4, Kevin D. Kissell <kevink@mips.com>:
> They also have some physical security and cryptography accelleration
> features, some of which use extended CPU state that would
> require some kernel context management support if anyone wanted
> to actually use them in Linux applications. The real point of
> having a CPU_4KSC config flag would be to enable building-in
> such support.
>

what is extended CPU state that you're talking about ?

> I'm being a teeny bit vague about this, because I'm not 100%
> certain that all the details of "SmartMIPS" have been published.
>

hmm, does that mean that smart mips extension couldn't be supported in
Linux in case that this extension have not been published ?

Thanks
--
               Franck
