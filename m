Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 17:18:36 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.235]:36308 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038861AbXBMRSc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 17:18:32 +0000
Received: by qb-out-0506.google.com with SMTP id e12so789079qba
        for <linux-mips@linux-mips.org>; Tue, 13 Feb 2007 09:17:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iSADV7FD1cRYlSwZhpcxSFwW4iV5i/V+qtu5iiYMChHKEJsO70bIc/gyxA7NrPB05hsIhSozgYSGCJuT6M5D7mPHIwXTxUKN0Y64AgZiA1iCnKQFC380JfZIlw0M38ndupsL82XpNOV9VsakQ0aC3viNxVP+twscOFPI0yJjhxY=
Received: by 10.114.211.1 with SMTP id j1mr6879450wag.1171387045157;
        Tue, 13 Feb 2007 09:17:25 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Tue, 13 Feb 2007 09:17:25 -0800 (PST)
Message-ID: <cda58cb80702130917p42f40743y7497090d7f489725@mail.gmail.com>
Date:	Tue, 13 Feb 2007 18:17:25 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 3/3] signal.c: fix gcc warning on 32 bits kernel
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
In-Reply-To: <20070213020556.GA5875@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070209210014.GA26939@linux-mips.org>
	 <cda58cb80702120101k770e059end43579394206b9d2@mail.gmail.com>
	 <20070212140459.GA9679@linux-mips.org>
	 <20070213.002545.03977174.anemo@mba.ocn.ne.jp>
	 <20070213014345.GA30988@linux-mips.org>
	 <20070213020556.GA5875@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/13/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Feb 13, 2007 at 01:43:45AM +0000, Ralf Baechle wrote:
>
> > Well, I reverted that the old state of a warning is definately preferable
> > until we found a proper solution.
>
> Type-punning should do the trick.
>
yes it does.

thanks.
-- 
               Franck
