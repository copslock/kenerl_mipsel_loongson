Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76Egxn06183
	for linux-mips-outgoing; Mon, 6 Aug 2001 07:42:59 -0700
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76EgxV06180
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 07:42:59 -0700
Received: from localhost.localdomain (taarna.cygnus.com [205.180.230.102])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id HAA17617;
	Mon, 6 Aug 2001 07:42:47 -0700 (PDT)
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
From: Eric Christopher <echristo@redhat.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: "H . J . Lu" <hjl@lucon.org>, gcc@gcc.gnu.org, linux-mips@oss.sgi.com,
   GNU
	C Library <libc-alpha@sourceware.cygnus.com>
In-Reply-To: <20010806164000.E400@rembrandt.csv.ica.uni-stuttgart.de>
References: <20010806164000.E400@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 06 Aug 2001 15:41:28 +0100
Message-Id: <997108890.1773.22.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> I don't know if this is an good idea. BITS_PER_WORD is 64bit for mips64,
> this might be wrong for wchar_t. At least the code for irix6 defines
> WCHAR_TYPE_SIZE == 32.
> 

Hrm.  You might be right.  I was thinking that would be correct though.
AFAICT from reading the c++ standard, it doesn't care about the size of
wchar_t as long as it is large enough to hold the values from the
supported locales.

Perhaps some c++ expert could help with this a bit?  Benjamin is there a
problem if wchar_t becomes 64-bits?

-eric

-- 
Look out behind you!
