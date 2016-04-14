Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2016 19:36:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40366 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026577AbcDNRgwhzIo5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Apr 2016 19:36:52 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u3EHapQ7009766;
        Thu, 14 Apr 2016 19:36:51 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u3EHanWK009765;
        Thu, 14 Apr 2016 19:36:49 +0200
Date:   Thu, 14 Apr 2016 19:36:49 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Dmitry.Dunaev@baikalelectronics.ru
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Constantine.Gurin@baikalelectronics.ru,
        Alexey.Malahov@baikalelectronics.ru
Subject: Re: New MIPS SoC code insertion request
Message-ID: <20160414173649.GB1003@linux-mips.org>
References: <E6691421972ADD4588ABC5DDDF6E279B8734754A@NRMAIL.baikal.int>
 <E6691421972ADD4588ABC5DDDF6E279B87347565@NRMAIL.baikal.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E6691421972ADD4588ABC5DDDF6E279B87347565@NRMAIL.baikal.int>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Apr 14, 2016 at 02:43:06PM +0000, Dmitry.Dunaev@baikalelectronics.ru wrote:

> I'm Dmitry Dunaev, software designer from Baikal Electronics - Russian
> semiconductor company (http://www.baikalelectronics.com/). Some time ago
> we are released our first MIPS processor based on P5600 core
> (https://www.linux-mips.org/wiki/Baikal).
> 
> Now we have this SoC in silicon. Also we have released several revisions
> of development boards for our SoC. So it seems that we ready to add our
> platform code into Linux kernel mainline.
> 
> Could you please clarify me what steps we should to do to add our code
> into kernel repositary?

I generally recommend to start the process of upstreaming the code early
possibly even before general availability of a new SoC or platform.
Generally the process of posting a version of patches, review, changing
issues has to go through several cycles before the code and documentation
will have reached a shape where it is deemed acceptable.  And even then
code will only be accepted for the merge window of the next kernel
release so worst case that could be another like good four months.

Basically the steps are:

 - Cleanup your code.
 - Split your patches into reasonably sized patches.  You are using
   git to create postable patches, so use options -C -M to enable the
   copy and rename detection which may make patches much smaller and
   easier to review.
 - Read the following files in the kernel:

     Documentation/SubmitChecklist
     Documentation/SubmittingDrivers
     Documentation/SubmittingPatches

Here's an example how a reasonably split patchset to add a new feature
may look like:

  https://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=1459415142-3412-1-git-send-email-matt.redfearn%40imgtec.com

And another one adding support for a new platform including a few drivers:

  https://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=1452734299-460-1-git-send-email-joshua.henderson%40microchip.com

I assume you will be posting several support for the core platfroms as well
as several drivers.  If the maintainers of the respective driver subsystems
are ok with that, I can carry the patches along with the platform support
in the MIPS tree which generally makes the the process somewhat easier.

  Ralf
