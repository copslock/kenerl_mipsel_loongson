Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76FZNQ12970
	for linux-mips-outgoing; Mon, 6 Aug 2001 08:35:23 -0700
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76FZMV12967
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 08:35:22 -0700
Received: from localhost.localdomain (taarna.cygnus.com [205.180.230.102])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id IAA21293;
	Mon, 6 Aug 2001 08:35:12 -0700 (PDT)
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
From: Eric Christopher <echristo@redhat.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, gcc@gcc.gnu.org,
   linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sourceware.cygnus.com>
In-Reply-To: <20010806082904.C15666@lucon.org>
References: <20010806164000.E400@rembrandt.csv.ica.uni-stuttgart.de>
	<997108890.1773.22.camel@ghostwheel.cygnus.com> 
	<20010806082904.C15666@lucon.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 06 Aug 2001 16:33:54 +0100
Message-Id: <997112036.2480.14.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> Yes. Gcc won't even compile since cpp uses MAX_WCHAR_TYPE_SIZE, which
> is defined as WCHAR_TYPE_SIZE and has be to a constant. But mips'
> BITS_PER_WORD is not avaiable for cpp. Besides, we use 32bit wchar_t
> on most of the 64bit Linux targets. Why do we want to use 64 for
> mips64? Check out WCHAR_TYPE_SIZE on ia64 and alpha, which are all
> 64bit Linux targets.
> 

Right.  alpha doesn't define WCHAR_TYPE_SIZE, ia64 seems to do what you
want...

-eric


-- 
Look out behind you!
