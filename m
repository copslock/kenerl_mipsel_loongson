Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 May 2006 01:02:37 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:17170 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133574AbWEPXC3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 May 2006 01:02:29 +0200
Received: from 10.10.64.154 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 16 May 2006 16:02:12 -0700
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 2BD7E2AF; Tue, 16 May 2006 16:02:12 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 075772B1 for
 <linux-mips@linux-mips.org>; Tue, 16 May 2006 16:02:12 -0700 (PDT)
Received: from mail-irva-12.broadcom.com (mail-irva-12.broadcom.com
 [10.10.64.146]) by mail-irva-8.broadcom.com (MOS 3.7.5-GA) with ESMTP
 id DNQ08553; Tue, 16 May 2006 16:02:11 -0700 (PDT)
Received: from dhcp-mhtb-6-13.ne.broadcom.com (
 dhcp-mhtb-6-13.ne.broadcom.com [10.28.6.13]) by
 mail-irva-12.broadcom.com (Postfix) with ESMTP id 1790E69CA3; Tue, 16
 May 2006 16:02:10 -0700 (PDT)
Subject: 16K page size
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:	linux-mips@linux-mips.org
Organization: broadcom
Date:	Tue, 16 May 2006 19:02:10 -0400
Message-ID: <1147820530.19832.10.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006051607; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230332E34343641353742442E303034332D412D;
 ENG=IBF; TS=20060516230213; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006051607_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6874867E4I812331286-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips


Recently, Fuxin Zhang published a set of tools to convert
elf executables to 16k pages.  Does anyone have a pointer
to a linux kernel source tree that has the necessary changes
to support 16k pages?

   Thanks.
