Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 13:37:02 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:39100 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493974AbZLHMg6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Dec 2009 13:36:58 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB8CavEG021569;
        Tue, 8 Dec 2009 12:36:57 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB8CavdB021567;
        Tue, 8 Dec 2009 12:36:57 GMT
Date:   Tue, 8 Dec 2009 12:36:57 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH resend] MIPS: more replace CL_SIZE by COMMAND_LINE_SIZE
Message-ID: <20091208123657.GB20624@linux-mips.org>
References: <20091208165844.ddd9106f.yuasa@linux-mips.org>
 <20091208172444.9e48afe7.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091208172444.9e48afe7.yuasa@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 08, 2009 at 05:24:44PM +0900, Yoichi Yuasa wrote:

> Sorry, I forgot one more CL_SIZE.
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>

I fixed these in the pull tree for Linus a few days ago along with a few
other issues and I was planning to get these fixes into the main tree
indirectly by just pulling from Linus.

Thanks!

  Ralf
