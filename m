Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2004 04:04:29 +0100 (BST)
Received: from gate.ebshome.net ([IPv6:::ffff:64.81.67.12]:30681 "EHLO
	gate.ebshome.net") by linux-mips.org with ESMTP id <S8225307AbUJPDEV>;
	Sat, 16 Oct 2004 04:04:21 +0100
Received: (qmail 1138 invoked by uid 1000); 15 Oct 2004 20:04:14 -0700
Date: Fri, 15 Oct 2004 20:04:14 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Pete Popov <ppopov@embeddedalley.com>
Cc: =?us-ascii?B?PT9JU08tODg1OS0xP1E/?= =AAL=AB=D8=A6w ?= 
	<Mickey@turtle.ee.ncku.edu.tw>, linux-mips@linux-mips.org
Subject: Re: Is there any means to use Cramfs and JFFS2 images as root disks?
Message-ID: <20041016030414.GB934@gate.ebshome.net>
Mail-Followup-To: Pete Popov <ppopov@embeddedalley.com>,
	=?us-ascii?B?PT9JU08tODg1OS0xP1E/?= =AAL=AB=D8=A6w ?= <Mickey@turtle.ee.ncku.edu.tw>,
	linux-mips@linux-mips.org
References: <002f01c4b2dc$cd1262e0$7101a8c0@dinosaur> <20041015174542.20487.qmail@web81008.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015174542.20487.qmail@web81008.mail.yahoo.com>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Return-Path: <ebs@ebshome.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebs@ebshome.net
Precedence: bulk
X-list: linux-mips

On Fri, Oct 15, 2004 at 10:45:42AM -0700, Pete Popov wrote:

[snipped]

> parameters to the kernel.  Your parameters above are
> incorrect. rootfstype=jffs2 will not be recognized.

Why? 

rootfstype is perfectly legal parameter. I use it frequently to tell 
the kernel not to try _every_ registered filesystem when mounting 
root.

--
Eugene
