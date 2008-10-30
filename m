Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 15:02:25 +0000 (GMT)
Received: from zrtps0kp.nortel.com ([47.140.192.56]:44942 "EHLO
	zrtps0kp.nortel.com") by ftp.linux-mips.org with ESMTP
	id S22735937AbYJ3PCO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Oct 2008 15:02:14 +0000
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com [47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id m9UF1Oi27672;
	Thu, 30 Oct 2008 15:01:24 GMT
Received: from [47.130.80.67] ([47.130.80.67] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Oct 2008 11:01:23 -0400
Message-ID: <4909CC40.1010106@nortel.com>
Date:	Thu, 30 Oct 2008 09:01:20 -0600
From:	"Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	David Daney <ddaney@caviumnetworks.com>,
	linux-mips <linux-mips@linux-mips.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: Re: [PATCH 00/36] Add Cavium OCTEON processor support (v2).
References: <490655B6.4030406@caviumnetworks.com> <alpine.LFD.1.10.0810291905020.13373@ftp.linux-mips.org>
In-Reply-To: <alpine.LFD.1.10.0810291905020.13373@ftp.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2008 15:01:24.0071 (UTC) FILETIME=[603F4F70:01C93AA0]
Return-Path: <CFRIESEN@nortel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cfriesen@nortel.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Mon, 27 Oct 2008, David Daney wrote:
> 
> 
>>This patch set introduces preliminary support for Cavium Networks'
>>OCTEON processor family.  More information about these processors may
>>be obtained here:
>>
>>http://www.caviumnetworks.com/OCTEON_MIPS64.html
> 
> 
>  Well, in the context of a technical mailing list there isn't much more 
> information available at the link you've quoted; although I do understand 
> you might not be the most appropriate person to point it to.  Honestly, 
> stating: "The family comprises SOC devices built around MIPS64 cores" 
> would provide about as much (little) information as the web site does. :(

You can register for free at www.cnusers.org and they have a bit more 
information there as well as existing SDKs with full linux source for 
older versions.  However, it looks like the really gory details are 
available only after signing an NDA.

Chris
