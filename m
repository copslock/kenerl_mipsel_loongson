Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6L1g7u12941
	for linux-mips-outgoing; Fri, 20 Jul 2001 18:42:07 -0700
Received: from dea.waldorf-gmbh.de (u-129-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.129])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6L1g4V12938
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 18:42:05 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6L1fe022905;
	Sat, 21 Jul 2001 03:41:40 +0200
Date: Sat, 21 Jul 2001 03:41:40 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: kjlin <kj.lin@viditec-netmedia.com.tw>
Cc: linux-mips@oss.sgi.com
Subject: Re: weird printf problem
Message-ID: <20010721034140.C22637@bacchus.dhis.org>
References: <016701c110c6$a371d580$056aaac0@kjlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <016701c110c6$a371d580$056aaac0@kjlin>; from kj.lin@viditec-netmedia.com.tw on Fri, Jul 20, 2001 at 10:49:45AM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 20, 2001 at 10:49:45AM +0800, kjlin wrote:

> Why too much "printf" will cause the program to die?
> Is it the problem of uClibc or kernel?
> Does the compiler for my testing program concern this weird problem?
> Can anybody give me some hints?

You gave no details such as sw version numbers and hardware details.  However
given such random behaviour my guess would be a kernel bug, possibly the TLB
or cache managment code doesn't handle your CPU right.

  Ralf
