Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8I3lMh20791
	for linux-mips-outgoing; Mon, 17 Sep 2001 20:47:22 -0700
Received: from groucho.maths.monash.edu.au (groucho.maths.monash.edu.au [130.194.160.211])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8I3lKe20788
	for <linux-mips@oss.sgi.com>; Mon, 17 Sep 2001 20:47:20 -0700
Received: (from rjh@localhost)
	by groucho.maths.monash.edu.au (8.8.8/8.8.8) id DAA01979
	for linux-mips@oss.sgi.com; Tue, 18 Sep 2001 03:47:16 GMT
From: Robin Humble <rjh@groucho.maths.monash.edu.au>
Message-Id: <200109180347.DAA01979@groucho.maths.monash.edu.au>
Subject: Re: openssh probs
To: linux-mips@oss.sgi.com
Date: Tue, 18 Sep 2001 13:47:16 +1000 (EST)
In-Reply-To: <Pine.SOL.4.31.0109171218020.15630-100000@fury.csh.rit.edu> from "George Gensure" at Sep 17, 2001 12:20:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>Yeah, should've mentioned the version.  I'm already running 2.9p2.  The

It's an endian build problem in the openssl library. Are you running
the H. J. Lu  RH7.1 distro? If so then this was a week or so ago and
the updated rpm and srpm on the site now work fine on my R4600 Indy.

If you want to recompile the openssl library yourself then find the
L_ENDIAN in the Configure file entry for linux-mips, change it to
B_ENDIAN and rebuild.

cheers,
robin
