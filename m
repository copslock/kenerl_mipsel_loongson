Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f452vQZ01248
	for linux-mips-outgoing; Fri, 4 May 2001 19:57:26 -0700
Received: from mail.ocs.com.au (ppp0.ocs.com.au [203.34.97.3])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f452vNF01245
	for <linux-mips@oss.sgi.com>; Fri, 4 May 2001 19:57:23 -0700
Received: (qmail 399 invoked from network); 5 May 2001 02:57:21 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 5 May 2001 02:57:21 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@melbourne.sgi.com>
To: "Patrick Fisher" <pbfisher@seas.upenn.edu>
cc: linux-mips@oss.sgi.com
Subject: Re: Executing Programs from initrd 
In-reply-to: Your message of "Fri, 04 May 2001 22:36:31 -0400."
             <019801c0d50c$32024fb0$2dd75b82@serendipity> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 05 May 2001 12:57:20 +1000
Message-ID: <13883.989031440@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 4 May 2001 22:36:31 -0400, 
"Patrick Fisher" <pbfisher@seas.upenn.edu> wrote:
>However, any attempt to execute it returns "No such file or directory".

That particular error message is highly misleading.  Most people read
it as "the file I'm trying to execute does not exist" but it is also
issued when the loader cannot be found or one of the run time libraries
cannot be found.  At a guess you have a mismatch between the mipsel
loader and the Nino loader.  Run strings on a working and a failing
binary and look at the required loader and libraries, usually the first
few strings.
