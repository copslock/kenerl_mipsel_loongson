Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 20:11:08 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:51388 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835050Ab3DOSLHPBgvE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Apr 2013 20:11:07 +0200
Received: by mail-pa0-f53.google.com with SMTP id bh4so2672808pad.26
        for <linux-mips@linux-mips.org>; Mon, 15 Apr 2013 11:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=UgTZ2cP57bprHcbeQVtv99RFJE4Tj89rCwXJ8T4E25s=;
        b=evRX98WEqZ02eX7r8TgJ3oGgNR7p+i2UQavBmU1TOxri+Ma6fQLJHd3sEiroO2cmKO
         zZGEd2NL/v7aRAVsLXLmCzJFd15hpHfrlF2HVlk2+lpw9t33v0px3ce32sx7tjtH8ElB
         TdJ4b4hRpIH6sLQDG0Fmt2rPuf7R4J4P1EPKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-gm-message-state;
        bh=UgTZ2cP57bprHcbeQVtv99RFJE4Tj89rCwXJ8T4E25s=;
        b=Io2/XpfRJgJwkYYp2nmiA3v67yTx27SnCq3zdOnmOSg6sV2FVXZ5UqdhPFpKkA603F
         VvfT+HJecRJBAZl+FGeIDZByeDLE4oo71uDyqJLHFGb22fARpOrfYJPmxf/cHhdx8lYa
         4bC12OLYldpVntGhNEEzkbvTHTwU9vGoqUre1hL+SD5ZNgyW5fBVcLUpxwtJBX8ZVlip
         HuNGpVgXr7bNfSRUk6XLM7uPHNj4ZUa3GLgXfPP0kTclP5vizM7cHaPjEbIYSgE3hvx4
         rdPn/eZun+08rI5RAFKkxMJlRmTh8Wu8XP2z+Dq276lNtAuCzO+42Cnmfj/N2TRddbxK
         KhPw==
X-Received: by 10.68.32.198 with SMTP id l6mr15236930pbi.187.1366049460375;
        Mon, 15 Apr 2013 11:11:00 -0700 (PDT)
Received: from localhost ([32.154.78.73])
        by mx.google.com with ESMTPS id n6sm6289200pbn.6.2013.04.15.11.10.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 11:10:59 -0700 (PDT)
Date:   Mon, 15 Apr 2013 11:10:53 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH 2/3] tty: serial: add iosize field to struct uart_port
Message-ID: <20130415181053.GA24990@kroah.com>
References: <1365845618-16040-1-git-send-email-blogic@openwrt.org>
 <1365845618-16040-3-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1365845618-16040-3-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnvDWwHfA6t5m0FAKtq+vgwmN0CmbHo040SxZkMjuKqJlsgF9WtQjUTBkdIVxsIV0FO3OVG
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Sat, Apr 13, 2013 at 11:33:37AM +0200, John Crispin wrote:
> From: Gabor Juhos <juhosg@openwrt.org>
> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>

Why?  You provide no justification for this patch here, so I guess I
can't accept it.

sorry,

greg k-h
