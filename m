Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jul 2018 19:12:14 +0200 (CEST)
Received: from mail-by2nam03on0098.outbound.protection.outlook.com ([104.47.42.98]:38880
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993860AbeGBRMHDiOMG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Jul 2018 19:12:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ4YnHJ+FiVc+AN13u9gAoV2xQT+Smy/XrP3n8YgdoI=;
 b=N3RPC4NkFkqKD0y2Rcndf8YVnBnR9QE/PdV/bpJ4eZROCyiD1TVGnvDr/OVt3fFpPhSYenYYZDbBCbe1tym4tj3PWhjxTu7uyGsp0pIjARfoxY3SbZg9mhCX3o11RX3qUaltNzFKi/vbH8MaJBdVzSmjTJRfz6Qafk0MhPVDdVs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Mon, 2 Jul 2018 17:11:56 +0000
Date:   Mon, 2 Jul 2018 10:11:54 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org,
        Chandrakala Chavva <cchavva@caviumnetworks.com>
Subject: Re: [PATCH v4] MIPS: Octeon: Remove unused CIU types and macros.
Message-ID: <20180702171154.uahxnzxd5aus56e6@pburton-laptop>
References: <1530541717-17426-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530541717-17426-1-git-send-email-steven.hill@cavium.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CY4PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:903:32::24) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 100291d6-70e8-485a-07de-08d5e03eea4f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:Lx/a9PQmjti0MX7xQpso1bkXBix+L9D9hcX1yH6fVT+foMKeMQj6dS1rALWKKchwSdYwC2Ou6q11a/9720JEMwMbsQxXfktteYbbKF+OWCJ6fnBC73L1vwSZ+CaxU0TnA5WBbkGu3sq6TGBWzXB/5jR0MqO2Sg1q8brGyK+z8u6tw0HsJGshgi2M3ee8Q5QV/5mBen0MmbGIfHIABaWwjWko5pjC7BxoOzlZmfZyb6oK2MO0GiCt7WfGZIqhwqgU;25:3GZBV/m6z+TpE1QUW7qrRFRnxzo97KXTCbUaJUbXIFpP8mocv/zVI1EyZJAaG8Y2ds7oYbX+UaXL/rBJrZVwWH39AtVkyoyjp4tIvheZS1clp33D13KA9xFv65dgKmpaP2HaF/7Na2vQQveodbhNJfbTvRYX58r8q9DolTCoJzaj6L1pCmoMYOOH8dha1MiWY48jLht85Oxeof1HZBxVaT7jnXRG5hR88+bwm5/Fsr4Eyd4ibfRfmwHfQ27bcH3oHHIr/VtNIAwgTK/E9ofmcz3vl4WflouwV4kHKtsZlJxF3bWQJ5r1HkJBVN0l8gCRhYH3Jbt2rLYo86oll3To7g==;31:Ws0h3Irya/eCjgYq4P/LmKscDSO8nMuhLVzmU1qVhWaODXHYzi+cf3PfVJcxqDn9P+I7JxoE00KXSSF+8Fl2FCOAx6dEcYF3Xq5gNDST0S2r1xPLOE7daSCYY2/al5oMcXxXC7PYyJhsQahhwb8Qba1dRLRri2uYcMXS61XFzrdujBRxegERiuX3fO5YLvcLF3442ffdUFNa9BUUQ/PJfZtcLYA0RE/zMIDFkJ6LTzw=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:Ef+xWbAZKidDV6jk6miq3zqWVUgl6yNCm6JQSLVrqCsm/eo502atiG0oHQ8XbQf/gwgLHBgclXitxYMMeP/g54y99mlPaXLE8H3K4UGU6MtZrW/4CDEyLRPscrmALmUoNz136yJ2sccgEdOUiF0CFwKYDrHmqFeoEe07mbYfw0u4XGZxMOqX9MQ5Y04FcWZU8LUXzbpQH8fAabHPU7xddrT1/UGGtaIaqcHU4d4Bewwb4JH2/LE4AswHcM+FY95O;4:o9K5/8403ViQuWyZDYezW3cRjmaH3/ZrrkXUg9URSfjj+12vzkJ2mIBVA6HTFARsLpQHySiw9oCdL8L1ibRxQ8NoI8+kWOfsvrx41oa5+GA0h3zKKu4mggKljy+OIGmmlhMpu0HdsLkSpehn0QQeOt/AcBPIshNBb/H1emdtBOaUglEFFsMDUcU71nUHqIXWh895lk0Uh89NawJtI0VmtFfEoV1If5gMP0RvDW3/utPtrCfQkG/q40KwnEs/y0/rcQXYgn6GkB8ijilNYvEztA==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4934B8A5EB22C578B33E321FC1430@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(149027)(150027)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(39840400004)(396003)(136003)(376002)(346002)(199004)(189003)(42882007)(6486002)(53936002)(6246003)(106356001)(33716001)(105586002)(97736004)(1076002)(47776003)(66066001)(68736007)(478600001)(6916009)(5660300001)(3846002)(6116002)(23726003)(26005)(229853002)(386003)(76506005)(16526019)(50466002)(186003)(305945005)(33896004)(52116002)(76176011)(6496006)(25786009)(9686003)(11346002)(446003)(956004)(81156014)(8936002)(2906002)(8676002)(81166006)(476003)(7736002)(44832011)(486006)(316002)(4326008)(58126008)(16586007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:k6zAdBl3+8lvjyAO8ivCAn+ISdmuzicbDPxkCzVuy?=
 =?us-ascii?Q?6P9YNNKV/UXvcpEmN3ZHRgeMnEzNYy2HQFhsHKl/ad4fHzl5anT6K1K+jwbe?=
 =?us-ascii?Q?0/Flzzj/sudOjweGUNWGxWP8NrAzvNo5+pfSv+uS1JjumVwjf/lEXtvf9BMg?=
 =?us-ascii?Q?+SmfBDdwiZNjcJ2PXqOjKsHEoAp3YAgTFtoPYvCzLtJlhOncn1LfHwjvxT7y?=
 =?us-ascii?Q?JXUW0JuLDHN8lcIjYtNxbZ0gqHkU501USNsBL743OGYVuI/wer/IKbkAiXEW?=
 =?us-ascii?Q?QnZibO2C+/JbP+67vuwYWEtDgDe1PaPcoTyUNB08S3wEOa4ZAQkkdjtqglwz?=
 =?us-ascii?Q?Og6AzATYf191Smwy3V4Rxa2hZ7qJN58VOs75d8sQ8XqLQjn1HOQpLVg+QvlN?=
 =?us-ascii?Q?eFmMTb23dqV8KHMopk/f4L/MVJlLbaWFVq7kRrxbquPxpFZ3ZWi19zCs29UI?=
 =?us-ascii?Q?UeIf51z/dsBbjwr8D+Yn5mWgsJGW6UjzHcQVFYBoQiaj9fK1AGtHQ7G/igol?=
 =?us-ascii?Q?QOJjNYyx5QK2EER6RuPyO6OGHKOJk7b0BC3n88xsd9RID/3J34yey/EM8EQJ?=
 =?us-ascii?Q?VmDeIv7G1hhITVHMuOm1Gbr6/EuL5d3ZeErpIVmpzu7/IKA9lLhlgCQqEhZi?=
 =?us-ascii?Q?Yo4NNyrvvmbw0yO45h6krcGoj1e1ppW/rhNNsOg3otu4/a2Bvd5NWpCpw1ZN?=
 =?us-ascii?Q?DC2m1RLwG8RY7noJ9aR47dy/j023lXhUtlTKbNffJkiIZzZVRRjukHEx7gsq?=
 =?us-ascii?Q?V/arZEmDBhKvyooH5veuuSnkq7U7dhhVqNFtXPHtZArqYd1DCN/4m25OHMJ7?=
 =?us-ascii?Q?2CXtc8MciSa0SvrLJ9hkcj1KNMN0HQskB/bEZrJzv2GlZBpzYKjs2MNFULh3?=
 =?us-ascii?Q?WVxBcFA3kuT6Wf1/grBvYdBdjPVRj7HtJlRFO4u8YLv5jC1F5BjMA+d3XWqB?=
 =?us-ascii?Q?0Ito8pbxf1HzunXhpaX7acY7tH8ibza4UusLBuFoALlokYMpdHvrcifmdBSK?=
 =?us-ascii?Q?I4S/VoczpIi1k0nXmgcOrwNSWEikiZcqes+CToQJ6tpDFjGR4nQ4xlzgCaVg?=
 =?us-ascii?Q?H6h1Lf9lQ2tu0oKzyR8cg2TJxn2bAUyQ4iHeQsLsiDisQ/streXshm1cM6zn?=
 =?us-ascii?Q?VLnuWpyRFNPDlZp1xuYEDgQZuYlZ7rRctnIie3CYzVew3sBSMbqqxkVHH4C3?=
 =?us-ascii?Q?06JamMPPo3L1OyXpo9r4MhktKPqlNafSU38PNFImaKIC8aIgoyakM8Y6yrI/?=
 =?us-ascii?Q?h7t6gk/H4e0SnhCH8UKmb933dCqW3hsXbn10/UI?=
X-Microsoft-Antispam-Message-Info: Y6uqvcTH6OvYYON9aRP3Yt38gRYEFW3Vz6CHpgZ6Kzp+jSoqZIc/F81K0x3bywozHVu4vwSMnj+mzx9eEV6Uw/Bk/oNZKclg9A/CvVcDr/8/jjCkwAcjOLmt8ZCayWw18eu8I/CtrAbtvsFVBFnSFqOH8iX+bQSO5xZBUFRWaMSiBxi7aOzlK8W9yItNGQBoECCCMym7aGOh9QUa0dtUIYoKrAw5ZGMMNzv6u2HYGQtOgJZd4+aHN6v+3PtxSQeg6LMhtBYTMRDOSAJJuVZU4oFehbiz3ekNATnA4QCuppyvZQtI+Rp+F45x+erHLyRVTOqdHBDMR4Sx2E/25TZrKA3FHsaff8FVcZrUkm6r/k8=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:ZfVPgbjQx12pWgKz2barbaFZhnB0Cnd6uG+wdTNb24MbZSvlKGV0NPl5IYi6bx4mwhtZZTvT9MmhMTFRXYnuwbsYVBge7myJeSlxji4562uuSQ/Ob4fc4YvJLtiTW3L4rzuBCTKz0r0H8ia3F2+BbA9wIbVvRIA3URe2+RQsRebonJK9YZeWy+a8yPFA2cvKrVdovkzBWJzT8DVYUg2ElBrLJwDpU4wXvpQ5ubJ0m08lV4zMAyj+bI7d+Rl3jQhcAWVTZp+sQwZtaBmmUsS77XM9yPrhQju2APl1/sbKlxJsOWVH6g1BoDTF9ld7vkwUkUSCE0fw+scSIx+uvGCK3UZDpUSu24U7VqnAb5IEGUx/jj9RYF0CPMsnoN7QxC6RtJ3DNcJCJv48pp2cuDd0ei7zW81vwEHKmMiv5tkrQ7OEM6z55odt6zEBFRNg5cKPRh92QmS5gkyOASZYTsYb1A==;5:cInvc7Vc5ogN2P6jeGOrFhY63bJ1CyPiwnOxyKOmugDTbs27DIaYSKE0O3zVRjgPXz1BWrNvhfpIDrrD6uBi6OWSJfERstCTl3vshApwj9H+hFq62m0+mUH7v7DakUEqHGmknCXrnpLVkyEAWj7vxTxgFv0zHz21AV3HdXDBgIE=;24:nBM9w8SYfJ7YhP6XSzQ2nIzpPDhhuXG8a0BF/ROuq+o0FmBL/AIzqkTHRg0JFDPFcPojnE2mNZTxrENS2Lu9nHqkb6rwk2IzXjhCMa1+J0M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;7:gBiw+EB4HZAUZGg2IxUdOb4Aps+C8uLE5KByIBbZd6MJiA1My8/oO1LzfW1lOsWopydiyEekCrm3083Sh35xfosqcWx2rBDHvIt9haE3UoHf9+VS4EsDBRXXKM3WhFbZT+gzPPMXk0GZOsKRQIY0Cpywc9/9PIHXCB5rhgNZm4ATP5GNqd/I4/dg0BbbEhDozQHEJMiLdAOWHb1HBtRhGhnrERcKJgMh/iXUsoKE2OZtp0Die5YYYA5eSFNTw2P9
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 17:11:56.4716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 100291d6-70e8-485a-07de-08d5e03eea4f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Steven,

On Mon, Jul 02, 2018 at 09:28:37AM -0500, Steven J. Hill wrote:
> +	if ((cvmx_get_proc_id() & OCTEON_PRID_MASK) == OCTEON_CN68XX)
> +		return CVMX_CIU_ADDR(0x100100600, coreid, 0xffff, 8);
> +	else
> +		return CVMX_CIU_ADDR(0x0680, coreid, 0xffff, 8);

Nope - that still isn't going to work...

We have in asm/octeon/octeon-model.h:

  #define OM_IGNORE_REVISION      0x01000000
  #define OCTEON_CN68XX_PASS2_0   0x000d9108
  #define OCTEON_CN68XX           (OCTEON_CN68XX_PASS2_0 | OM_IGNORE_REVISION)

So that gives us the equivalent of:

  #define OCTEON_CN68XX           0x010d9108

You take the result of cvmx_get_proc_id() and AND it with:

  #define OCTEON_PRID_MASK        0x00ffffff

After this bits 31:24 will always be zero, and therefore the resulting
value can *never* equal OCTEON_CN68XX which has bit 24 set.

Thanks,
    Paul
