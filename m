Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76GObU16986
	for linux-mips-outgoing; Mon, 6 Aug 2001 09:24:37 -0700
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76GOaV16983
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 09:24:36 -0700
Received: from localhost.localdomain (taarna.cygnus.com [205.180.230.102])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id JAA25190;
	Mon, 6 Aug 2001 09:24:30 -0700 (PDT)
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
From: Eric Christopher <echristo@redhat.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, gcc@gcc.gnu.org,
   linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sourceware.cygnus.com>
In-Reply-To: <20010806083942.A16047@lucon.org>
References: <20010806164000.E400@rembrandt.csv.ica.uni-stuttgart.de>
	<997108890.1773.22.camel@ghostwheel.cygnus.com>
	<20010806082904.C15666@lucon.org>
	<997112036.2480.14.camel@ghostwheel.cygnus.com> 
	<20010806083942.A16047@lucon.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 06 Aug 2001 17:23:11 +0100
Message-Id: <997114994.12490.0.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> 
> alpha does:
> 
> # grep WCHAR_TYPE defaults.h config/alpha/linux.h
> defaults.h:#ifndef WCHAR_TYPE_SIZE
> defaults.h:#define WCHAR_TYPE_SIZE INT_TYPE_SIZE
> config/alpha/linux.h:#undef WCHAR_TYPE
> config/alpha/linux.h:#define WCHAR_TYPE "int"
> # grep INT_TYPE_SIZE config/alpha/*.h
> config/alpha/alpha.h:#define INT_TYPE_SIZE 32
> 
> So WCHAR_TYPE_SIZE is 32 for Linux/alpha.
> 

Ah ha.  I'd not looked into defaults.h. Ok.  Nevermind then.

-eric


-- 
Look out behind you!
