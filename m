Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2015 09:32:45 +0100 (CET)
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38594 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006924AbbLAIckpHPPU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2015 09:32:40 +0100
Received: by wmec201 with SMTP id c201so2571740wme.1
        for <linux-mips@linux-mips.org>; Tue, 01 Dec 2015 00:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LE4rBeSoPRQMXBgE8lzhHbzOfqcxzKy8YI5nEnBVq7U=;
        b=J1FiBu43ZTaBOcbDm5KgzM89e5P6VAOZQNS9FtZstcpZoISQCX4zAU8qJTTblaC5dr
         DxZOhkuM9SdkDm9HxrDhp69ev8DzUhE8DJk9QqBtgXLscXq72sGRcmVh9nVnZ5AolmP/
         ObiX0QMLOgmKvhbCZD7EaJnOGlmdEeroptzFSinwdCc/4WecsRHzs6Jj6dha3IpmvOUQ
         gW5pzyMdlY0hpiJC6nMlLWBLmeFOvkV0ALA2ZIqgEikJaimcgrjdOt/eFNRleD69VH3/
         prAe0rZhNdUSxxtDHOAY0w22Hpu1idVxJ+pr4fh9G3/ZWVPWjaZzM6OulUm6GXcd7PCh
         9iEg==
X-Received: by 10.194.236.6 with SMTP id uq6mr55860266wjc.126.1448958755423;
        Tue, 01 Dec 2015 00:32:35 -0800 (PST)
Received: from netboy (188-22-24-46.adsl.highway.telekom.at. [188.22.24.46])
        by smtp.gmail.com with ESMTPSA id ft4sm50186997wjb.37.2015.12.01.00.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Dec 2015 00:32:34 -0800 (PST)
Date:   Tue, 1 Dec 2015 09:32:32 +0100
From:   Richard Cochran <richardcochran@gmail.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/28] ptp: pch: allow build on MIPS platforms
Message-ID: <20151201083232.GA5772@netboy>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
 <1448900513-20856-19-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448900513-20856-19-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <richardcochran@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richardcochran@gmail.com
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

On Mon, Nov 30, 2015 at 04:21:43PM +0000, Paul Burton wrote:
> Allow the ptp_pch driver to be built on MIPS platforms in preparation
> for use on the MIPS Boston board.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>
