Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78F4ng11712
	for linux-mips-outgoing; Wed, 8 Aug 2001 08:04:49 -0700
Received: from gandalf.codesourcery.com (227.dsl6660148.rstatic.surewest.net [66.60.148.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78F4mV11705
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 08:04:48 -0700
Received: from gandalf.codesourcery.com (IDENT:mitchell@localhost [127.0.0.1])
	by gandalf.codesourcery.com (8.9.3/8.9.3) with ESMTP id IAA01008;
	Wed, 8 Aug 2001 08:04:42 -0700
Date: Wed, 08 Aug 2001 08:04:41 -0700
From: Mark Mitchell <mark@codesourcery.com>
To: Eric Christopher <echristo@redhat.com>, "H . J . Lu" <hjl@lucon.org>
cc: "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: PATCH: Clean up Linux/mips.
Message-ID: <11900000.997283081@gandalf.codesourcery.com>
In-Reply-To: <997281490.1290.49.camel@ghostwheel.cygnus.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



--On Wednesday, August 08, 2001 03:38:08 PM +0100 Eric Christopher 
<echristo@redhat.com> wrote:

> Quick question:  You said you tested, but I wanted to verify that you
> were able to bootstrap with no regressions?  If so, then it is approved
> for the trunk.  Mark will need to approve for the branch.

What incredibly critical problem does this solve?  Recall that 3.0.1
is currently frozen, waiting only for some breakage in V3-land to get
fixed, before we produce a release candidate.

Thanks,

--
Mark Mitchell                   mark@codesourcery.com
CodeSourcery, LLC               http://www.codesourcery.com
