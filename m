Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76NoNf29884
	for linux-mips-outgoing; Mon, 6 Aug 2001 16:50:23 -0700
Received: from dea.waldorf-gmbh.de (u-157-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.157])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76NoJV29878
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 16:50:20 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f76NnA123038;
	Tue, 7 Aug 2001 01:49:10 +0200
Date: Tue, 7 Aug 2001 01:49:10 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Eric Christopher <echristo@redhat.com>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
   "H . J . Lu" <hjl@lucon.org>, gcc@gcc.gnu.org, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
Message-ID: <20010807014910.B22966@bacchus.dhis.org>
References: <20010806164000.E400@rembrandt.csv.ica.uni-stuttgart.de> <997108890.1773.22.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <997108890.1773.22.camel@ghostwheel.cygnus.com>; from echristo@redhat.com on Mon, Aug 06, 2001 at 03:41:28PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 06, 2001 at 03:41:28PM +0100, Eric Christopher wrote:

> Hrm.  You might be right.  I was thinking that would be correct though.
> AFAICT from reading the c++ standard, it doesn't care about the size of
> wchar_t as long as it is large enough to hold the values from the
> supported locales.
> 
> Perhaps some c++ expert could help with this a bit?  Benjamin is there a
> problem if wchar_t becomes 64-bits?

On 64-bit MIPS ABI compliant machines I see wchar_t defined to __int32_t
which again is int.

  Ralf
