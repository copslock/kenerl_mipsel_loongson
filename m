Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DLrTs15433
	for linux-mips-outgoing; Thu, 13 Sep 2001 14:53:29 -0700
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DLrSe15429
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 14:53:28 -0700
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id f8DLrO204736;
	Thu, 13 Sep 2001 17:53:24 -0400
Date: Thu, 13 Sep 2001 17:53:24 -0400
From: Jim Paris <jim@jtan.com>
To: Gerald Champagne <gerald.champagne@esstech.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: How can I determine which files are used?
Message-ID: <20010913175324.A4728@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <3BA12877.6030505@esstech.com> <20010913175007.A4641@neurosis.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010913175007.A4641@neurosis.mit.edu>; from jim@jtan.com on Thu, Sep 13, 2001 at 05:50:07PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> make clean
> find . | xargs touch -t 198001010101
> make
> find . -not atime -1 | xargs rm $i
> 
> Which would set all of the access times to be really old, 
> rebuild everything, and then remove all files which weren't
> touched during the build.

Slight correction: make that last command

find . -not -atime -1 | xargs rm $i

and the last sentence "which weren't accessed during the build".
Still untested though :)

-jim
