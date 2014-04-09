Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2014 11:03:31 +0200 (CEST)
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:64064 "EHLO
        cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815804AbaDIJD2vW47C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Apr 2014 11:03:28 +0200
Received: from cpsps-ews08.kpnxchange.com ([10.94.84.175]) by cpsmtpb-ews01.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 9 Apr 2014 11:03:22 +0200
Received: from CPSMTPM-TLF104.kpnxchange.com ([195.121.3.7]) by cpsps-ews08.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 9 Apr 2014 11:03:22 +0200
Received: from [192.168.10.106] ([195.240.213.44]) by CPSMTPM-TLF104.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 9 Apr 2014 11:03:21 +0200
Message-ID: <1397034201.22767.15.camel@x220>
Subject: Re: MIPS: Remove last traces of SMTC Support too?
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Date:   Wed, 09 Apr 2014 11:03:21 +0200
In-Reply-To: <53450BBE.7050501@imgtec.com>
References: <1397033309.22767.8.camel@x220> <53450BBE.7050501@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-2.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Apr 2014 09:03:21.0629 (UTC) FILETIME=[8E840CD0:01CF53D2]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39740
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

Hi Markos,

On Wed, 2014-04-09 at 09:58 +0100, Markos Chandras wrote:
> I talked to Ralf yesterday. It seems the patch was not applied correctly 
> and there are a few traces left. My original patch definitely removes 
> the traces listed in your patch.

Assuming Ralf and you sort this out, and a complete removal of SMTC
support will eventually hit linux-next, I won't be bothering you again.

Thanks,


Paul Bolle
