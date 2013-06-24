Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jun 2013 01:24:17 +0200 (CEST)
Received: from mail-pb0-f42.google.com ([209.85.160.42]:35138 "EHLO
        mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834840Ab3FXXYPvWVqH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jun 2013 01:24:15 +0200
Received: by mail-pb0-f42.google.com with SMTP id un1so11717731pbc.15
        for <multiple recipients>; Mon, 24 Jun 2013 16:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LdgGCDHevXWPwRhfwldfh41c5nLKPzKcW73G9WxRwnA=;
        b=KWn9aGZNhZJnckk+849B+bh4IvB35nch+BS4D7SPBbW6ZIzZz9/mlo2MeZ522j0+vF
         DcOKr+Km8K1ol0jbEdumpo7/DDlsPji+oKAndWTVyYlFr7zF4FSOecJaMfhoGWrkkQsj
         PZtIY3cCVkW3ryqHMrwSNDtXKg40IUYKyz+Kw818Pgm3INCNnLkHM55yc3F+K3NkboRq
         ql/J6JU98ViWopuYnZBggUtfTMceeXvWcZZkcinLykt5crtDHF7gUCqv4VhZu+1zpEXa
         DF0+WCtaSTrq54wy3SKJhDYvkZVnIo9lU6wPqFUfJMKr0O1EnYTw4rXuDuslXSRy0NaW
         qt3A==
X-Received: by 10.68.190.104 with SMTP id gp8mr25741094pbc.120.1372116248949;
        Mon, 24 Jun 2013 16:24:08 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id re16sm21935222pac.16.2013.06.24.16.24.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:24:08 -0700 (PDT)
Message-ID: <51C8D516.6010008@gmail.com>
Date:   Mon, 24 Jun 2013 16:24:06 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 1/2] MIPS: cavium-octeon: cvmx-helper-board: print
 unknown board warning only once
References: <1372023524-17333-1-git-send-email-aaro.koskinen@iki.fi> <51C89567.3000108@gmail.com> <20130624220429.GB20703@blackmetal.musicnaut.iki.fi> <51C8C940.7080106@gmail.com> <20130624230639.GC20703@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20130624230639.GC20703@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 06/24/2013 04:06 PM, Aaro Koskinen wrote:
> On Mon, Jun 24, 2013 at 03:33:36PM -0700, David Daney wrote:
>> On 06/24/2013 03:04 PM, Aaro Koskinen wrote:
>>> On Mon, Jun 24, 2013 at 11:52:23AM -0700, David Daney wrote:
>>>> On 06/23/2013 02:38 PM, Aaro Koskinen wrote:
>>>>> When booting a new board for the first time, the console is flooded with
>>>>> "Unknown board" messages. This is not really helpful. Board type is not
>>>>> going to change after the boot, so it's sufficient to print the warning
>>>>> only once.
>>>>>
>>>>> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>>>>
>>>> I don't think we need this patch.  In 2/2 you add the board type for
>>>> the board you have, so you shouldn't be getting any messages, and
>>>> this is unneeded.
>>>>
>>>> I don't mind spamming people with all the messages,  if people see
>>>> these messages, they have bigger problems than too many messages.
>>>
>>> I guess this patch can be dropped, but whoever tries to improve the
>>> support for the next new Octeon board will get annoyed by these same
>>> messages...
>>
>> I would hope that the "next new Octeon board" would have a
>> bootloader that supplies a device tree.  That way most of this would
>> never be used, and there would be no messages.
>
> Yes, actually I was wondering if MIPS kernel could offer something
> similar to ARM's APPENDED_DTB, i.e. provide some mechanism to pass the
> dtb if the bootloader support is missing.
>

Well the octeon port does supply its own device tree if one isn't passed 
from the bootloader.  And your patch 2/2 supplies the information used 
populate it.

But that is not quite the same I think.  It would be nice to be able to 
pass on the command line something.  Then you could load a blob from the 
boot ROM or similar and get something sensible.

David Daney
