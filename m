Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76EeIr05778
	for linux-mips-outgoing; Mon, 6 Aug 2001 07:40:18 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76EeGV05767
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 07:40:16 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id QAA166552;
	Mon, 6 Aug 2001 16:40:00 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15TlY0-0003ro-00; Mon, 06 Aug 2001 16:40:00 +0200
Date: Mon, 6 Aug 2001 16:40:00 +0200
To: Eric Christopher <echristo@redhat.com>
Cc: "H . J . Lu" <hjl@lucon.org>, gcc@gcc.gnu.org, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
Message-ID: <20010806164000.E400@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <997107178.1253.7.camel@ghostwheel.cygnus.com>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Eric Christopher wrote:
> 
> > I am working on will be the first gcc 3.x for Linux/mips. So there
> > shouldn't be any problems. Am I right?
> 
> I _think_ you are ok doing this.
> 
> I just noticed from your patch that you set the size to 32-bits.  Please
> set it to BITS_PER_WORD.

I don't know if this is an good idea. BITS_PER_WORD is 64bit for mips64,
this might be wrong for wchar_t. At least the code for irix6 defines
WCHAR_TYPE_SIZE == 32.


Thiemo
