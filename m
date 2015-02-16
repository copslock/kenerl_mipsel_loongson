Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Feb 2015 09:39:39 +0100 (CET)
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:56699 "EHLO
        cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012242AbbBPIjhspRbR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Feb 2015 09:39:37 +0100
Received: from cpsps-ews18.kpnxchange.com ([10.94.84.184]) by cpsmtpb-ews09.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 16 Feb 2015 09:39:32 +0100
Received: from CPSMTPM-TLF102.kpnxchange.com ([195.121.3.5]) by cpsps-ews18.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 16 Feb 2015 09:39:32 +0100
Received: from [192.168.10.106] ([77.173.140.92]) by CPSMTPM-TLF102.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 16 Feb 2015 09:39:32 +0100
Message-ID: <1424075972.9418.131.camel@x220>
Subject: Re: MIPS: CONFIG_MIPS_R6?
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     Valentin Rothberg <valentinrothberg@gmail.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 16 Feb 2015 09:39:32 +0100
In-Reply-To: <54DFF4EE.6010008@imgtec.com>
References: <1423934469.9418.18.camel@x220> <54DFF4EE.6010008@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2015 08:39:32.0272 (UTC) FILETIME=[15D93B00:01D049C4]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Leonid,

On Sat, 2015-02-14 at 17:22 -0800, Leonid Yegoshin wrote:
> On 02/14/2015 09:21 AM, Paul Bolle wrote:
> > Your commits 430857eae56c ("MIPS: mm: Add MIPS R6 instruction
> > encodings") and 90163242784b ("MIPS: kernel: unaligned: Add support for
> > the MIPS R6") are included in yesterday's linux-next (ie,
> > next-20150213). I noticed because a script I use to check linux-next
> > spotted a problem with it.
> >
> > These commits added three references to CONFIG_MIPS_R6, were probably
> > CONFIG_CPU_MIPSR6 was intended. One reference is in a comment, which
> > should be trivial to get fixed. The other two references are in
> > (negative) preprocessor checks. It's not certain, at least not to me,
> > how these should be fixed.
> >
> >
> > Paul Bolle
> 
> Yes, please.

The obvious fix (ie, three times s/CONFIG_MIPS_R6/CONFIG_CPU_MIPSR6/)
isn't trivial and requires run time testing, which I have no idea how to
do, sorry.


Paul Bolle
