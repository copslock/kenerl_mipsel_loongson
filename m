Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f332Iwh15850
	for linux-mips-outgoing; Mon, 2 Apr 2001 19:18:58 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f332IvM15847
	for <linux-mips@oss.sgi.com>; Mon, 2 Apr 2001 19:18:57 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id EAA62054;
	Tue, 3 Apr 2001 04:17:41 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.12 #1 (Debian))
	id 14kGO4-0006Oj-00; Tue, 03 Apr 2001 04:17:40 +0200
Date: Tue, 3 Apr 2001 04:17:40 +0200
To: "Steven J. Hill" <sjhill@cotw.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Binutils fixed to deal with 'insmod' issue and discussion...
Message-ID: <20010403041740.G5099@rembrandt.csv.ica.uni-stuttgart.de>
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses> <3AC90E16.AEF59359@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3AC90E16.AEF59359@cotw.com>; from sjhill@cotw.com on Mon, Apr 02, 2001 at 06:41:10PM -0500
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Steven J. Hill wrote:
[snip]
>Without the binutils patch, all binaries compiled for MIPS/Linux
>will be IRIX flavored which was the whole problem.

Please may You elaborate about this? AFAICS, the IRIX flavour
can't be a problem by itself.

>I would now
>like to make 'elf[32|64]_trad[little|big]mips' be the official
>targets instead of 'elf[32|64]_[little|big]mips' which is what
>things currently are. This means changing of linker scripts in
>GLIBC as well as the Linux kernel (as far as I can tell). I would
>like to propose the any 'mips*-*-linux-gnu' and 'mips*el-*linux-gnu'
>targets be pure traditional targets WITHOUT any emulated IRIX targets
>which are the current 'elf[32|64]_[little|big]mips' targets. Please
>provide feedback, comments, etc. with justification. Thanks.

Changing the MIPS/Linux ABI to circumvent a toolchain bug seems
to be a bit extremistic. Am I missing some important details?


Thiemo
