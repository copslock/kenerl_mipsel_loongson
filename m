Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76GTi817281
	for linux-mips-outgoing; Mon, 6 Aug 2001 09:29:44 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76GTgV17277;
	Mon, 6 Aug 2001 09:29:42 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 54FA7125C3; Mon,  6 Aug 2001 09:29:41 -0700 (PDT)
Date: Mon, 6 Aug 2001 09:29:41 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Andreas Jaeger <aj@suse.de>, Eric Christopher <echristo@redhat.com>,
   gcc@gcc.gnu.org, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
Message-ID: <20010806092941.A16954@lucon.org>
References: <20010805094806.A3146@lucon.org> <20010806115913.B17179@bacchus.dhis.org> <hoofptjy6k.fsf@gee.suse.de> <20010806182050.A21142@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010806182050.A21142@bacchus.dhis.org>; from ralf@oss.sgi.com on Mon, Aug 06, 2001 at 06:20:50PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 06, 2001 at 06:20:50PM +0200, Ralf Baechle wrote:
> 
> H.J. - why did you want to change this type anyway?  "long int" and "int"
> both have the same size and signedness so there isn't any incompatibility
> anyway?
> 

All Linux targets should use a 32bit type, `int', for wchar_t. `long'
is 64bit for mips64.

Like I said, we don't use the mips API, only the ABI.


H.J.
