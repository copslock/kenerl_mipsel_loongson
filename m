Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f857V8r15423
	for linux-mips-outgoing; Wed, 5 Sep 2001 00:31:08 -0700
Received: from tamaris.wanadoo.fr (smtp-rt-12.wanadoo.fr [193.252.19.60])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f857V1d15420
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 00:31:02 -0700
Received: from villosa.wanadoo.fr (193.252.19.122) by tamaris.wanadoo.fr; 5 Sep 2001 09:30:52 +0200
Received: from ez (193.253.187.170) by villosa.wanadoo.fr; 5 Sep 2001 09:30:49 +0200
Subject: Re: How to install the cross-compiler toolchain?
From: Jean-Christophe ARNU <jc.arnu@wanadoo.fr>
To: kjlin <kj.lin@viditec-netmedia.com.tw>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <008901c135c6$87b88c60$056aaac0@kjlin>
References: <008901c135c6$87b88c60$056aaac0@kjlin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 05 Sep 2001 09:27:40 -0400
Message-Id: <999696461.4471.15.camel@ez>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 05 Sep 2001 12:52:13 +0800, kjlin wrote:
> #rpm -ivh glibc-2.2.3-13.3.i386.rpm 
> error: failed dependencies:
>                 glibc-common = 2.2.3-13.3 is needed by glibc-2.2.3-13.3
>                 glibc-devel < 2.2.3 conflicts with glibc-2.2.3-13.3
> I also tried to install glibc-common-2.2.3-13.3.i386.rpm but still failed.
> #rpm -ivh glibc-common-2.2.3-13.3.i386.rpm
> error: failed dependencies:
>                 glibc < 2.2.3 conflicts with glibc-common-2.2.3-13.3
> 
> I am confused by the result.

	You should update and not install glibc.
	# rpm -uvh glibc-common-2.2.3.13.3.i386.rpm

	
-- 
Jean-Christophe ARNU
s/w developer 
Paratronic France
