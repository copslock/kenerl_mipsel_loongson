Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5703InC029779
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 6 Jun 2002 17:03:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5703Iro029778
	for linux-mips-outgoing; Thu, 6 Jun 2002 17:03:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5703FnC029775
	for <linux-mips@oss.sgi.com>; Thu, 6 Jun 2002 17:03:15 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAB02202
	for <linux-mips@oss.sgi.com>; Thu, 6 Jun 2002 17:05:25 -0700 (PDT)
	mail_from (ica2_ts@csv.ica.uni-stuttgart.de)
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17G74T-000NB7-00; Fri, 07 Jun 2002 01:53:37 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17G75i-0001ln-00; Fri, 07 Jun 2002 01:54:54 +0200
Date: Fri, 7 Jun 2002 01:54:54 +0200
To: Ilya Volynets <ilya@theIlya.com>
Cc: nick@snowman.net, linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
Message-ID: <20020606235453.GA5079@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020603235311.GJ23411@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.21.0206041341130.31816-100000@ns> <20020605223736.GN23411@rembrandt.csv.ica.uni-stuttgart.de> <20020605235041.7895.qmail@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020605235041.7895.qmail@gateway.total-knowledge.com>
User-Agent: Mutt/1.3.28i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ilya Volynets wrote:
[snip]
> > > Is it also an R10k system, or are
> > > you useing an r4k system?
> >
> > IT's r10k. AFAIH the r4k systems have still ARCS32 and should be
> > able to boot a 32 bit kernel.
> And how are you dealing with R10K speculative execution
> in non-cache-coherent systems problem?

Not yet. I plan to modify the assembler for it.


Thiemo
