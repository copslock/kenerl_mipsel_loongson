Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2004 09:14:52 +0000 (GMT)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:37380 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8224985AbUCEJOv>;
	Fri, 5 Mar 2004 09:14:51 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id i258nWp08594;
	Fri, 5 Mar 2004 03:49:32 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i259ElM14827;
	Fri, 5 Mar 2004 04:14:48 -0500
Received: from [172.16.25.141] (dhcp-172-16-25-141.sfbay.redhat.com [172.16.25.141])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i259ElR05912;
	Fri, 5 Mar 2004 01:14:47 -0800
Subject: Re: gcc support of mips32 release 2
From: Eric Christopher <echristo@redhat.com>
To: Long Li <long21st@yahoo.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20040305075517.42647.qmail@web40404.mail.yahoo.com>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1078478086.4308.14.camel@dzur.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 05 Mar 2004 01:14:47 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips


> Seems to me, this mips32 release 2 is an extension of
> mips32, added some new instructions, eg. EHB, etc. So
> would it be necessary that gcc be updated, like what
> gnu as has done, in the future to reflect this
> extension?

It will be in the soon to be released 3.4. Contributed by Chris
Demetriou of Broadcom.

-eric

-- 
Eric Christopher <echristo@redhat.com>
