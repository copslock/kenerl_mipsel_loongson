Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4INqcK11718
	for linux-mips-outgoing; Fri, 18 May 2001 16:52:38 -0700
Received: from pobox.sibyte.com (pobox.sibyte.com [208.12.96.20])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4INqcF11715
	for <linux-mips@oss.sgi.com>; Fri, 18 May 2001 16:52:38 -0700
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP
	id 9A76E205FC; Fri, 18 May 2001 16:53:12 -0700 (PDT)
Received: from SMTP agent by mail gateway 
 Fri, 18 May 2001 16:44:10 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP
	id 010AC15961; Fri, 18 May 2001 16:52:33 -0700 (PDT)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 4A400686D; Fri, 18 May 2001 16:52:31 -0700 (PDT)
From: Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To: stevenliu@psdc.com
Subject: Re: mips-tfile
Date: Fri, 18 May 2001 16:50:25 -0700
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
Cc: linux-mips@oss.sgi.com
References: <000801c0a572$b7471e40$dde0490a@BANANA> <20010517223139.A19781@bacchus.dhis.org> <000801c0dff4$3870ba60$dde0490a@pcs.psdc.com>
In-Reply-To: <000801c0dff4$3870ba60$dde0490a@pcs.psdc.com>
MIME-Version: 1.0
Message-Id: <01051816523009.00779@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 18 May 2001, Steven Liu wrote:
> Hi ALL:
> 
> I have a question regarding MIPS Makefile.
> 
> In the Makefile of the Linux build directory, there are two Macros of C
> compiler flags: HOSTCFLAGS and CFLAGS.
> 
> What are their purpose and difference? In another words, what is host gcc?
> Why do we use host gcc in building the target kernel?
> 

See Documentation/kbuild/makefiles.txt.

-Justin
