Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2011 22:39:48 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3489 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491757Ab1JUUjn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2011 22:39:43 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ea1d8dc0000>; Fri, 21 Oct 2011 13:41:00 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 21 Oct 2011 13:39:40 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 21 Oct 2011 13:39:38 -0700
Message-ID: <4EA1D87A.1090708@cavium.com>
Date:   Fri, 21 Oct 2011 13:39:22 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Noor <noor.mubeen@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: cause IP zero on interrupt
References: <CAMmEz3QV+kWvRK9KnUdmKFGqNA8XUspjc_cH7aYXfea5XYaRAg@mail.gmail.com>
In-Reply-To: <CAMmEz3QV+kWvRK9KnUdmKFGqNA8XUspjc_cH7aYXfea5XYaRAg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2011 20:39:40.0833 (UTC) FILETIME=[8EABE910:01CC9031]
X-archive-position: 31266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15982

On 10/21/2011 01:18 PM, Noor wrote:
> what does it mean if cause register IP bits are zero after
> interrupt exception  has already been invoked ?
>

It might mean that something was asserting a '1' on to those bits, but 
quit doing so before you could read the cause register, or it could be 
that you get random interrupt exceptions for no reason at all.

David Daney
