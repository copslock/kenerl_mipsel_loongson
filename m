Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 16:53:03 +0100 (CET)
Received: from mail.netlogicmicro.com ([64.0.7.62]:1054 "EHLO
	orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1493995AbZKCPw5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 16:52:57 +0100
Received: from orion8.netlogicmicro.com ([10.1.1.7]) by 
	orion5.netlogicmicro.com with InterScan Message Security Suite; Tue, 03 Nov
	 2009 07:53:50 -0800
Received: from 12.234.128.66 ([12.234.128.66]) by orion8.netlogicmicro.com 
	([10.1.1.7]) with Microsoft Exchange Server HTTP-DAV ;Tue,  3 Nov 2009 
	15:53:49 +0000
Received: from kh-t3500 by 12.239.216.94; 03 Nov 2009 09:52:47 -0600
Subject: Re: addinitrd deletion
From:	Kevin Hickey <khickey@netlogicmicro.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20091103154854.GA9161@linux-mips.org>
References: <20091103121838.GA27403@linux-mips.org> 
	<1257262912.29642.9.camel@localhost> <20091103154854.GA9161@linux-mips.org>
Content-Type: text/plain;
	charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date:	Tue, 03 Nov 2009 09:52:46 -0600
Message-ID: <1257263566.29642.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
X-imss-version:	2.054
X-imss-result: Passed
X-imss-scanInfo: M:P L:N SM:0
X-imss-tmaseResult: TT:0 TS:0.0000 TC:00 TRN:0 TV:5.6.1016(16988.000)
X-imss-scores: Clean:99.90000 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:2 C:4 M:4 S:4 R:4 (0.1500 0.1500)
Return-Path: <khickey@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

On Tue, 2009-11-03 at 16:48 +0100, Ralf Baechle wrote:
> On Tue, Nov 03, 2009 at 09:41:52AM -0600, Kevin Hickey wrote:
> 
> > On Tue, 2009-11-03 at 13:18 +0100, Ralf Baechle wrote:
> > > Does anybody still see any use for addinitrd?  If not I'm going to delete
> > > it.
> > > 
> > FWIW I do not...
> 
> Well, I've already queued a patch to delete addinitrd and everything else
> that belongs to it.  So this question was one of these "speak up or forever
> hold your peace" kind of questions :-)

Then I guess it's good for me that I don't use it :)

> 
> I see you have a fancy new email address.

Yup.  RMI Corporation is now Netlogic Microsystems.  They wasted no time
in changing our email addresses.

=Kevin
