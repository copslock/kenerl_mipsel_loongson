Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DLoBB15347
	for linux-mips-outgoing; Thu, 13 Sep 2001 14:50:11 -0700
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DLo9e15344
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 14:50:09 -0700
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id f8DLo7q04707;
	Thu, 13 Sep 2001 17:50:07 -0400
Date: Thu, 13 Sep 2001 17:50:07 -0400
From: Jim Paris <jim@jtan.com>
To: Gerald Champagne <gerald.champagne@esstech.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: How can I determine which files are used?
Message-ID: <20010913175007.A4641@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <3BA12877.6030505@esstech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA12877.6030505@esstech.com>; from gerald.champagne@esstech.com on Thu, Sep 13, 2001 at 04:43:19PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Is there a recommended method of determining which files in the
> Linux source tree are used with a given .config file?  I've already
> removed the obvious things like unused entries in the arch directory
> and a couple of driver directories, but is there a way to generate a
> list of only the files that are used?
> 
> I know I've read discussions about someday splitting up the source code
> into smaller blocks, but can someone point me towards information on how
> to prune the existing source tree?

I suppose you could do a 

make clean
find . | xargs touch -t 198001010101
make
find . -not atime -1 | xargs rm $i

Which would set all of the access times to be really old, 
rebuild everything, and then remove all files which weren't
touched during the build.

(Be careful; I didn't actually test this command and I wouldn't
trust it too much without testing it, since it's quite capable
of wiping out the whole directory)

-jim
