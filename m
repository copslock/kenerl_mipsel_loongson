Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8SCc6S10599
	for linux-mips-outgoing; Fri, 28 Sep 2001 05:38:06 -0700
Received: from mail.ocs.com.au (mail.ocs.com.au [203.34.97.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8SCc3D10596
	for <linux-mips@oss.sgi.com>; Fri, 28 Sep 2001 05:38:03 -0700
Received: (qmail 3538 invoked from network); 28 Sep 2001 12:38:00 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 28 Sep 2001 12:38:00 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id 16BA03000B7; Fri, 28 Sep 2001 22:37:58 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id 02FE8B8; Fri, 28 Sep 2001 22:37:57 +1000 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@melbourne.sgi.com>
To: Kjeld Borch Egevang <kjelde@mips.com>
Cc: linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: Re: gcc crash 
In-reply-to: Your message of "Thu, 27 Sep 2001 16:59:47 +0200."
             <Pine.LNX.4.30.0109271657250.1742-100000@coplin19.mips.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Sep 2001 22:37:52 +1000
Message-ID: <19900.1001680672@ocs3.intra.ocs.com.au>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 27 Sep 2001 16:59:47 +0200 (CEST), 
Kjeld Borch Egevang <kjelde@mips.com> wrote:
>When I compile the following function with "gcc -O2" the compiler crashes.
>static float sp_f2l(float x)
>{
>    long l, *xl;
>    float y;
>
>    xl = (void *)&y;
>    l = x;
>    *xl = l;
>    return y;
>}

You are breaking the C rules for data accesses.  Compile with
-fno-strict-aliasing if you want to break the rules.  Or, and this is
much better, use a union of long and float to "convert" one
representation to another.
