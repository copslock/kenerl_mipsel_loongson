Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76HR9I18284
	for linux-mips-outgoing; Mon, 6 Aug 2001 10:27:09 -0700
Received: from dea.waldorf-gmbh.de (u-145-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.145])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76HR7V18278
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 10:27:07 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f76HPvu21492;
	Mon, 6 Aug 2001 19:25:57 +0200
Date: Mon, 6 Aug 2001 19:25:57 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Gabriel Dos_Reis <gdosreis@sophia.inria.fr>
Cc: Andreas Jaeger <aj@suse.de>, "H . J . Lu" <hjl@lucon.org>,
   Eric Christopher <echristo@redhat.com>, gcc@gcc.gnu.org,
   linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
Message-ID: <20010806192557.A21485@bacchus.dhis.org>
References: <20010805094806.A3146@lucon.org> <20010806115913.B17179@bacchus.dhis.org> <hoofptjy6k.fsf@gee.suse.de> <20010806182050.A21142@bacchus.dhis.org> <15214.52694.346958.536105@perceval.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15214.52694.346958.536105@perceval.inria.fr>; from gdosreis@sophia.inria.fr on Mon, Aug 06, 2001 at 07:04:36PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 06, 2001 at 07:04:36PM +0200, Gabriel Dos_Reis wrote:

> | > I'm confused.  The ABI defines it to be long - and he should change it
> | > nevertheless?
> | 
> | It's defined as a "long", not "long int" so we're obviously off by a tiny
> | bit.
> 
> As far as far C++ is concerned, there is no pedantic difference
> between "long" and "long int" and "signed long int".

Guess why I said a tiny bit :-)

  Ralf
