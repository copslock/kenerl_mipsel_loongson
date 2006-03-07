Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2006 05:54:49 +0000 (GMT)
Received: from smtp-out-0101.amazon.com ([207.171.180.182]:15069 "EHLO
	smtp-out-0101.amazon.com") by ftp.linux-mips.org with ESMTP
	id S8127233AbWCGFyf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Mar 2006 05:54:35 +0000
X-Amazon-Corporate-Relay: smtp-out-0101.sea3.amazon.com
X-AMAZON-TRACK:	ralf@linux-mips.org
Received: from smtp-in-2001.iad2.amazon.com by smtp-out-0101.amazon.com with ESMTP 
          (peer crosscheck: smtp-in-2001.iad2.amazon.com)
Received: from ex-gate-01.ant.amazon.com (ex-gate-01.ant.amazon.com [172.20.21.33])
	by smtp-in-2001.iad2.amazon.com (8.12.10/8.12.10) with ESMTP id k275xnRn025797;
	Tue, 7 Mar 2006 06:02:55 GMT
Received: from mail pickup service by ex-gate-01.ant.amazon.com with Microsoft SMTPSVC;
	 Mon, 6 Mar 2006 22:02:21 -0800
Received: from smtp-in-1001.vdc.amazon.com ([10.130.7.44]) by ex-gate-01.ant.amazon.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 6 Mar 2006 18:05:51 -0800
Received: from smtp-border-fw-1101.amazon.com (smtp-border-fw-1101.vdc.amazon.com [10.30.167.40])
	by smtp-in-1001.vdc.amazon.com (8.12.10/8.12.10) with ESMTP id k2724ch2017391
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <psubash@amazon.com>; Tue, 7 Mar 2006 02:05:47 GMT
Received: from vger.kernel.org ([209.132.176.167])
  by smtp-border-fw-1101.amazon.com with ESMTP; 07 Mar 2006 02:05:36 +0000
X-Amazon-External-Envelope-Sender: linux-kernel-owner+psubash=40amazon.com-S1752474AbWCGCDS@vger.kernel.org
X-Amazon-External-Envelope-Recipient: psubash@amazon.com
X-Amazon-External-Source: yes
X-Amazon-Approved-Domain: no
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,169,1139184000"; 
   d="scan'208"; a="179720437:sNHT27854144"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbWCGCDS (ORCPT <rfc822;psubash@amazon.com>);
	Mon, 6 Mar 2006 21:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbWCGCDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 21:03:18 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:64767 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1752474AbWCGCDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 21:03:17 -0500
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for vger.kernel.org [209.132.176.167]) with ESMTP; Tue, 7 Mar 2006 11:03:16 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id F25C820686;
	Tue,  7 Mar 2006 11:03:14 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id E7C8E20040;
	Tue,  7 Mar 2006 11:03:14 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k2723E4D080974;
	Tue, 7 Mar 2006 11:03:14 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 07 Mar 2006 11:03:14 +0900 (JST)
Message-Id: <20060307.110314.00927749.nemoto@toshiba-tops.co.jp>
To:	akpm@osdl.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64bit unaligned access on 32bit kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060306170552.0aab29c5.akpm@osdl.org>
References: <20050830104056.GA4710@linux-mips.org>
	<20060306.203218.69025300.nemoto@toshiba-tops.co.jp>
	<20060306170552.0aab29c5.akpm@osdl.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List:		linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 07 Mar 2006 02:05:51.0394 (UTC) FILETIME=[A8BE4820:01C6418B]
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 6 Mar 2006 17:05:52 -0800, Andrew Morton <akpm@osdl.org> said:
>> Use __u64 instead of __typeof__(*(ptr)) for temporary variable to
>> get rid of errors on gcc 4.x.

akpm> I worry about what impact that change might have on code
akpm> generation.  Hopefully none, if gcc is good enough.

akpm> But I cannot think of a better fix.

As I tested on MIPS gcc 3.x, the impact is not none, but not so huge.
And it becomes much smaller with gcc 4.x.

---
Atsushi Nemoto
