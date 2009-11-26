Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 19:10:01 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48894 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493750AbZKZSJ6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2009 19:09:58 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAQIAE2K019577;
        Thu, 26 Nov 2009 18:10:14 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAQIADLa019575;
        Thu, 26 Nov 2009 18:10:13 GMT
Date:   Thu, 26 Nov 2009 18:10:12 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [urgent] [loongson] YeeLoong-2F: Add missing macros for EC
Message-ID: <20091126181012.GA11737@linux-mips.org>
References: <1259245879-9632-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259245879-9632-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 26, 2009 at 10:31:19PM +0800, Wu Zhangjin wrote:

> Seems several macros for EC operations are missing, without this patch, the
> "MIPS: Yeeloong 2F: Add LID open event as the wakeup event" and "MIPS: Yeeloong
> 2F: Cleanup reset logic using the new ec_write function" will fail on
> compiling. And also, some macros are added for the coming platform specific
> drivers.
>       
> Could you please fold this patch to "MIPS: Yeeloong 2F: Add basic EC
> operations"?

Done.

  Ralf
