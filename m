Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 23:06:37 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51332 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493653AbZJHVGd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Oct 2009 23:06:33 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n98L7hwX015393;
	Thu, 8 Oct 2009 23:07:43 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n98L7e49015390;
	Thu, 8 Oct 2009 23:07:40 +0200
Date:	Thu, 8 Oct 2009 23:07:40 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/2] USB: Add USB HCD for Octeon SOCs.
Message-ID: <20091008210740.GB14560@linux-mips.org>
References: <4ACD2EBF.8020901@caviumnetworks.com> <4ACE1CBD.6000106@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACE1CBD.6000106@caviumnetworks.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 08, 2009 at 10:09:17AM -0700, David Daney wrote:

>> Some members of the Cavium Networks Octeon family of SOCs contain the
>> Synopsys DWC-OTG USB controller.  This patch set adds the
>> corresponding driver.
>>
>> The first patch adds between zero and two Octeon platform devices.
>> The second is the driver.
>>
>> I have done a little bit of clean-up on the driver code, but
>> undoubtedly the careful scrutiny of the USB maintainers will uncover
>> more opportunities for improvement.  I look foreword to seeing any
>> suggestions for how the code might be changed so that it could be
>> merged.
>>
>>
>> I will reply with the two patches.
>>
>
> I did in fact reply with the two patches.  However some spam filtering  
> seems to have stopped '[PATCH 2/2] USB: Add HCD for Octeon SOC' from  
> making it to the lists.
>
> Ralf has released it to linux-mips@linux-mips.org, but  
> linux-usb@vger.kernel.org seems to have eaten it.
>
> It had a Message-Id:  
> <1254960926-12185-2-git-send-email-ddaney@caviumnetworks.com>
>
> I won't send it again as it seems likely that it would get eaten again,  
> but if the list controllers for linux-usb could release it, that would  
> be nice.

Here's the archived version.

http://www.linux-mips.org/archives/linux-mips/2009-10/msg00064.html

There's a link on that page to get a mbox format version of that mail.

  Ralf
