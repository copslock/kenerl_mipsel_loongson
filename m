Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9D0u1I01756
	for linux-mips-outgoing; Fri, 12 Oct 2001 17:56:01 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9D0txD01753
	for <linux-mips@oss.sgi.com>; Fri, 12 Oct 2001 17:55:59 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (SGI-8.9.3/8.9.3) with ESMTP id CAA47444
	for <linux-mips@oss.sgi.com>; Sat, 13 Oct 2001 02:55:50 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.32 #1 (Debian))
	id 15sD5i-000717-00
	for <linux-mips@oss.sgi.com>; Sat, 13 Oct 2001 02:55:50 +0200
Date: Sat, 13 Oct 2001 02:55:50 +0200
To: linux-mips@oss.sgi.com
Subject: Re: Big endian problem
Message-ID: <20011013025550.B2413@rembrandt.csv.ica.uni-stuttgart.de>
References: <APEOLACBIPNAFKJDDFIIIEBLCBAA.hli@quicklogic.com> <3BC72CCC.3604FEC8@mvista.com> <3BC74EFE.9020109@quicklogic.com> <20011012173552.B3689@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011012173552.B3689@mvista.com>
User-Agent: Mutt/1.3.22i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun Sun wrote:
[snip]
> > Hanshi and I will look at the USECS_PER_JIFFY_FRAC macro.  Thanks for
> > the pointer.
> > 
> > -- Dan A.
> >
> 
> It is indeed a strange problem as it only shows up in BE tools.  
> Some tool gurus want to look into it?

I use the BE CVS tools and haven't seen this.
How does the preprocessed code look like?


Thiemo
