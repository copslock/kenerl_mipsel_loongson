Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2003 23:28:26 +0100 (BST)
Received: from mms2.broadcom.com ([IPv6:::ffff:63.70.210.59]:5642 "EHLO
	mms2.broadcom.com") by linux-mips.org with ESMTP
	id <S8225220AbTGUW2Y>; Mon, 21 Jul 2003 23:28:24 +0100
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.5.2)); Mon, 21 Jul 2003 15:24:51 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id PAA09376 for <linux-mips@linux-mips.org>; Mon, 21 Jul 2003 15:27:51
 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 h6LMSFov019439 for <linux-mips@linux-mips.org>; Mon, 21 Jul 2003 15:28:
 15 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id PAA28252 for
 <linux-mips@linux-mips.org>; Mon, 21 Jul 2003 15:28:15 -0700
Message-ID: <3F1C68FF.58E4E94D@broadcom.com>
Date: Mon, 21 Jul 2003 15:28:15 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: n32 signal stuff
X-WSS-ID: 1302B7B92208867-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

I've just checked in (with Ralf's approval) some changes for N32 signal
handling that came up as 64-bit tool and glibc support evolved in the
last few months.  Both 2.4 and 2.5/2.6 versions are there, but 2.4 has
had much more testing.

Credit where credit is due: this code was worked on by Chris Demetriou
and I just helped massage it into the public tree.

Hopefully there are no major complaints with this, although minor tweaks
are expected :-)

Kip
