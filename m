Received:  by oss.sgi.com id <S553814AbQJYPqV>;
	Wed, 25 Oct 2000 08:46:21 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:55049 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S553810AbQJYPqD>;
	Wed, 25 Oct 2000 08:46:03 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id IAA10464;
	Wed, 25 Oct 2000 08:45:44 -0700
Date:   Wed, 25 Oct 2000 08:45:44 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Glibc Problem
Message-ID: <20001025084544.A10373@chem.unr.edu>
References: <20001025160651.C17228@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001025160651.C17228@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Wed, Oct 25, 2000 at 04:06:51PM +0100
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Oct 25, 2000 at 04:06:51PM +0100, Ian Chilton wrote:

> I am having this problem cross-compiling todays CVS glibc:
> ../sysdeps/generic/dl-cache.c:181: `CACHEMAGIC_VERSION_NEW' undeclared (first use in this function)

A simple platform-independent typo. I'm sure it'll be fixed soon. In
the meantime here's a patch.

Index: dl-cache.c
===================================================================
RCS file: /cvs/glibc/libc/sysdeps/generic/dl-cache.c,v
retrieving revision 1.25
diff -u -r1.25 dl-cache.c
--- dl-cache.c	2000/10/25 08:07:18	1.25
+++ dl-cache.c	2000/10/25 15:41:06
@@ -178,13 +178,13 @@
 
 	  cache_new = (struct cache_file_new *) ((void *) cache + offset);
 	  if (cachesize < (offset + sizeof (struct cache_file_new))
-	      || memcmp (cache_new->magic, CACHEMAGIC_VERSION_NEW,
-			 sizeof CACHEMAGIC_VERSION_NEW - 1) != 0)
+	      || memcmp (cache_new->magic, CACHEMAGIC_NEW,
+			 sizeof CACHEMAGIC_NEW - 1) != 0)
 	    cache_new = (void *) -1;
 	}
       else if (file != NULL && cachesize > sizeof *cache_new
-	       && memcmp (cache_new->magic, CACHEMAGIC_VERSION_NEW,
-			  sizeof CACHEMAGIC_VERSION_NEW - 1) == 0)
+	       && memcmp (cache_new->magic, CACHEMAGIC_NEW,
+			  sizeof CACHEMAGIC_NEW - 1) == 0)
 	{
 	  cache_new = file;
 	  cache = file;


-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
